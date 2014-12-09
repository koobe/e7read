
/**
 * 
 */

var mapHomeApp = angular.module('MapHomeApp', ['userService', 'mapService', 'searchService', 'googleMapService']);

var onCall = false;
var eof = false;
var isGeoReady = false;

var defaultDistance = 10000;

var scopeContentFlowController;

mapHomeApp.controller('ContentFlowController', ['$scope', '$mapService', '$userService', '$searchService', '$googleMapService',
                                                function($scope, $mapService, $userService, $searchService, $googleMapService) {
	
	var channel = getQueryVariable("channel");
	var categoryName = getQueryVariable("c");
	var s = $.spinner();
	
	scopeContentFlowController = $scope;
	
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
			
			$('#btnSortByDistance').addClass('active');
			$('#btnSortByNewest').removeClass('active');
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
				
				var iconUrl;
				
				if (content.iconUrl) {
					iconUrl = content.iconUrl;
				} else if (content.categories && content.categories[0]) {
					iconUrl = content.categories[0].iconUrl;
				} else {
					iconUrl = content.channel.iconUrl;
				}
						
				$googleMapService.addMarker(content.location.lat, content.location.lon, {
					contentId: content.id,
					title: content.cropTitle,
					icon: iconUrl
				});
				
				setTimeout(function(){
					var html = getInfoWindowHTML(content);
					
					$googleMapService.setInfoWindow({
						contentId: content.id,
						content: html,
						maxWidth: 125
					});
				}, 300);
				
			});
			onCall = false;
			s.done();
		});
	};
	
	$scope.orderByDate = function() {
		if (isGeoReady) {
			$scope.searchLocation = {};
			$scope.loadContents(true);
		}
	};
	
	$scope.orderByNear = function() {
		if (isGeoReady) {
			$scope.searchLocation = $scope.lastSearchLocation;
			$scope.loadContents(true);
		}
	};
	
	$scope.setLocationBySensor = function() {
		
		s.loading('正在取得位置資訊...');
		isGeoReady = false;
		resetContent();
		
		$mapService.getCurrentPosition(function(position) {
			
			var lat = position.coords.latitude;
			var lon = position.coords.longitude;
			
			$googleMapService.moveTo(lat, lon);
			$googleMapService.setZoom(13);
			$googleMapService.showCenterCircle();
			
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
				
				$googleMapService.moveTo(lat, lon);
				$googleMapService.setZoom(13);
				$googleMapService.showCenterCircle();
				
				s.done();
				$scope.searchLocation = $scope.myLocation;
				$scope.loadContents(true);
				isGeoReady = true;
			} else {
				if ($scope.sensorLocation.lat) {
					
					$googleMapService.moveTo($scope.sensorLocation.lat, $scope.sensorLocation.lon);
					$googleMapService.showCenterCircle();
					
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
	};
	
	$scope.returnMyLocation = function() {
		if (isGeoReady) {
			$scope.setLocationByUserProfile();
		}
	};
	
	$scope.openContent = function(contentId) {
		showContent(contentId);
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
	
	$scope.openMapInfoWindow = function(contentId) {
		$googleMapService.openInfoWindow(contentId);
	};
	
	
	
	/**
	 * Google map
	 */
	
	
	$googleMapService.createMap('map-canvas', {});
	$googleMapService.addSearchBox('pac-input', {});
	$googleMapService.addMapControl('get-my', google.maps.ControlPosition.RIGHT_TOP);
	$googleMapService.addMapControl('get-current', google.maps.ControlPosition.RIGHT_TOP);
	
	
	
	$googleMapService.addSearchBoxListener('place_changed', function() {
		triggerMapReload();
	});
	
	if( /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ) {
		$googleMapService.addMapListener('bounds_changed', function() {
			triggerMapReload();
		});
	} else {
		$googleMapService.addMapListener('dragend', function() {
			triggerMapReload();
		});
	}
	
	function triggerMapReload() {
		var lat = $googleMapService.getMap().getCenter().k;
		var lon = $googleMapService.getMap().getCenter().B;
		defaultDistance = $googleMapService.getBoundDistance();
		$scope.searchLocation = {lat: lat, lon: lon, name: ''};
		$scope.loadContents(true);
		$googleMapService.showCenterCircle();
		$googleMapService.closeCurrentInfoWindow();
	}
	
	function getInfoWindowHTML(content) {
		var container = $('<div class="container"/>');
		
		var imgContainer = $('<div class="div-bg-thumbnail-cover info-window-image"/>');
		imgContainer.css('background-image', 'url(' + content.coverUrl + ')');
		
		var titleContainer = $('<div class="info-window-title" />');
		var title = $('<span/>').html(content.cropTitle);
		titleContainer.append(title);
		
		var separator = $('<div class="info-window-separator" />');
		
		var infoContainer = $('<div class="info-window-info" />');
		
		var author = $('<div><i class="fa fa-user"></i> <span>Cloude Lin</span><div/>');
		var date = $('<div><i class="fa fa-clock-o"></i> <span>12/31</span></div>');
		
		infoContainer.append(author).append(date);
		
		container.append(titleContainer).append(separator).append(imgContainer).append(infoContainer);
		return container.html();
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