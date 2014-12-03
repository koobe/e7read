var channel = getQueryVariable("channel");
var categoryName = getQueryVariable("c");
var s = $.spinner();


var mapOptions = {
    zoom: 8,
    center: new google.maps.LatLng(-34.397, 150.644)
};

var onCall = false;
var eof = false;
var isGeoReady = false;

var defaultDistance = 10000;
var defaultZoom = 14;

var scopeContentFlowController;

var mapHomeApp = angular.module('MapHomeApp', ['userService', 'mapService', 'searchService']);

mapHomeApp.controller('ContentFlowController', ['$scope', '$mapService', '$userService', '$searchService', 
                                                function($scope, $mapService, $userService, $searchService) {
	
	scopeContentFlowController = $scope;
	
	$scope.googlemap = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);;
	
	$scope.colXs = 12;
	$scope.colSm = 6;
	$scope.colMd = 4;
	
	$scope.myLocation = {};
	$scope.sensorLocation = {};
	$scope.searchLocation = {};
	$scope.lastSearchLocation = {};
	
	$scope.keyword = null;
	
	$scope.size = 12;
	$scope.page = 0;
	$scope.contents = [];
	
	// default search parameters
	var defaultSearchParams = {};
	defaultSearchParams.channel = channel;
	defaultSearchParams.distance = defaultDistance;
	if (categoryName) {
		defaultSearchParams.c = categoryName
	}
	
	$scope.loadContents = function(reset) {
		
		onCall = true;
		s.loading();
		
		if (reset) {
			resetContent();
		}
		console.log('Load... ' + $scope.page + ', ' + $scope.size);
		
		var lastName = $scope.locationName;
		
		var lat = $scope.searchLocation.lat;
		var lon = $scope.searchLocation.lon;
		$scope.locationName = $scope.searchLocation.name;
		
		var geo = null;
		if (lat && lon) {
			geo = lat + ',' + lon;
			console.log('Search near: ' + geo);
			$scope.lastSearchLocation.lat = lat;
			$scope.lastSearchLocation.lon = lon;
			$scope.lastSearchLocation.name = $scope.searchLocation.name;
		} else {
			$scope.locationName = lastName;
		}
		
		$scope.page++;
		var offset = ($scope.page * $scope.size) - $scope.size;
		
		var data = {size: $scope.size, offset: offset, geo: geo, q: $scope.keyword};
		angular.extend(data, defaultSearchParams);
		
		$searchService.searchContent(data, function(contents){
			if (contents.length == 0) {
				console.log('eof');
				eof = true;
			}
			angular.forEach(contents, function(content){
				if (geo != null) {
					content.distance = $mapService.distance(lat, lon, content.location.lat, content.location.lon, 'K');
				}
				$scope.contents.push(content);
				
				var myLatlng = new google.maps.LatLng(content.location.lat, content.location.lon);
				
				var iconUrl = content.iconUrl? content.iconUrl: content.channel.iconUrl
				
				var marker = new google.maps.Marker({
				      position: myLatlng,
				      map: $scope.googlemap,
				      title: content.cropTitle,
				      icon: iconUrl
				});
			});
			onCall = false;
			s.done();
		});
	};
	
	$scope.setLocationBySensor = function() {
		
		s.loading('正在取得位置資訊...');
		isGeoReady = false;
		resetContent();
		
		$mapService.getCurrentPosition(function(position) {
			
			var lat = position.coords.latitude;
			var lon = position.coords.longitude;
			
			moveToLocation(lat, lon, defaultZoom);
			
			$mapService.geocoding(lat, lon, function(name) {
				
				$scope.sensorLocation.lat = lat;
				$scope.sensorLocation.lon = lon;
				$scope.sensorLocation.name = name;
				
				s.done();
				isGeoReady = true;
				
				$scope.searchLocation = $scope.sensorLocation;
				$scope.loadContents(true);
			});
		});
		
		$('#btnSortByDistance').addClass('active');
		$('#btnSortByNewest').removeClass('active');
	};
	
	/**
	 * Set query location by user profile
	 */
	$scope.setLocationByUserProfile = function() {
		
		s.loading('正在取得位置資訊...');
		isGeoReady = false;
		resetContent();
		
		$userService.getLocation(function(location) {
			var lat = location.lat;
			var lon = location.lon;
			var name = location.name;
			
			if (lat != null && lon != null) {
				$scope.myLocation.lat = lat;
				$scope.myLocation.lon = lon;
				$scope.myLocation.name = name;
				
				moveToLocation(lat, lon, defaultZoom);
				
				s.done();
				$scope.searchLocation = $scope.myLocation;
				$scope.loadContents(true);
				isGeoReady = true;
			} else {
				if ($scope.sensorLocation.lat) {
					s.done();
					$scope.searchLocation = $scope.sensorLocation;
					$scope.loadContents(true);
					isGeoReady = true;
				} else {
					// set location by sensor
					$scope.setLocationBySensor();
				}
			}
		});
		
		$('#btnSortByDistance').addClass('active');
		$('#btnSortByNewest').removeClass('active');
	};
	
	$scope.initLocation = function() {
		$scope.setLocationByUserProfile();
	};
	
	$scope.initLocation();
	
	function resetContent() {
		$scope.contents = [];
		$scope.page = 0;
		eof = false;
	}
	
	
	
	
	function moveToLocation(lat, lng, zoom){
	    var center = new google.maps.LatLng(lat, lng);
	    $scope.googlemap.panTo(center);
	    $scope.googlemap.setZoom(zoom);
	}
	
}]);


mapHomeApp.directive('scrolling', function() {
	
	/**
	 * determine if load more data
	 */
	function shouldLoadMore(scrollingObj, contentObj) {
		var factor = scrollingObj.scrollTop() + scrollingObj.height() + 100;
		if ((contentObj.height() - factor) <= 0) { return true; } else { return false; }
	}
	
	return {
		restrict: 'A',
		link: function(scope, element, attrs) {
			
			var contentPane = $('.content-pane', element);
			
			element.scroll(function() {
					if (shouldLoadMore(element, contentPane) && !onCall && !eof) {
						scopeContentFlowController.loadContents();
					}
		        });
			element.on({
		            'touchmove': function(e) {
		            	if (shouldLoadMore(element, contentPane) && !onCall && !eof) {
		            		scopeContentFlowController.loadContents();
						}
		            }
		        });
		}
	};
});