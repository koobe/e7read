var channel = getQueryVariable("channel");
var categoryName = getQueryVariable("c");

var coverFlowApp = angular.module('coverFlowApp', ['ngResource', 'ngAutocomplete']);

coverFlowApp.config(function($provide, $compileProvider, $filterProvider) {
});

var s = $.spinner();

var coverFlowControllerScope;
var gPlacesAutoCompCtrlScope;
var onCall = false;
var eof = false;
var isGeoReady = false;

coverFlowApp.controller('CoverFlowController', ['$scope', '$resource', '$log', function($scope, $resource, $log) {
	
	coverFlowControllerScope = $scope;

	// create search parameters
	var params = {};
	params.channel = channel;
	params.distance = 5000;
	if (categoryName) {
		params.c = categoryName
	}
	var SearchContentRestService = $resource('/search/contents', {}, {
		search: {method:'GET', params:params, isArray: true}
	});
	
	var GeocodingRestService = $resource('/map/geocoding',{},{
		geocoding: {method:'GET'}
	});
	
	$scope.myLat = null;
	$scope.myLon = null;
	
	$scope.searchLat = null;
	$scope.searchLon = null;
	
	$scope.locationName;
	
	$scope.keyword = null;
	
	$scope.size = 12;
	$scope.page = 0;
	
	$scope.contents = [];
	
	$scope.loadContents = function(lat, lon) {
		$log.log('Load... ' + $scope.page + ', ' + $scope.size);
		onCall = true;
		
		s.loading();
		
		var geo = null;
		if (lat && lon) {
			geo = lat + ',' + lon;
			console.log('Search near: ' + geo);
		}
		
		$scope.page++;
		var offset = ($scope.page * $scope.size) - $scope.size;
		
		SearchContentRestService.search({size: $scope.size, offset: offset, geo: geo, q: $scope.keyword}, function(contents){
			if (contents.length == 0) {
				console.log('eof');
				eof = true;
			}
			angular.forEach(contents, function(content){
				if (geo != null) {
					content.distance = distance(lat, lon,
							content.location.lat, content.location.lon, 'K');
				}
				
				$scope.contents.push(content);
			});
			
			onCall = false;
			s.done();
		});
	};
	
	var searchInput;
	
	$scope.search = function(e) {
		
		if (e.keyCode == 13) {
			var target = angular.element(e.target);
			
			searchInput = target;
			
			console.log(target.val());
			
			$scope.contents = [];
			$scope.page = 0;
			eof = false;
			
			if (target.val() == null || target.val().trim() == '') {
				$scope.keyword = null;
			} else {
				$scope.keyword = target.val().trim();
			}
			
			$scope.loadContents($scope.searchLat, $scope.searchLon);
			
			target.blur();
		}
	}
	
	$scope.removeKeyword = function() {
		
		searchInput.val(null);
		
		$scope.contents = [];
		$scope.page = 0;
		eof = false;
		$scope.keyword = null;
		
		$scope.loadContents($scope.searchLat, $scope.searchLon);
	}
	
	s.loading('正在取得位置資訊...');
	
	//TODO Get geo point from user profile
	navigator.geolocation.getCurrentPosition(function(position) {
		var lat = position.coords.latitude;
		var lon = position.coords.longitude;
		
		$scope.myLat = lat;
		$scope.myLon = lon;
		
		$scope.searchLat = lat;
		$scope.searchLon = lon;
		
		s.done();
		
		$scope.loadContents(lat, lon);
		
		GeocodingRestService.geocoding({lat:lat, lon:lon}, function(data) {
			
			$scope.myLocationName = '';
			if (data.city) {
				$scope.myLocationName = $scope.myLocationName + data.city;
			}
			if (data.region) {
				$scope.myLocationName = $scope.myLocationName + data.region;
			}
			
			if ($scope.myLocationName == '') {
				$scope.myLocationName = data.country;
			}
			
			$scope.locationName = $scope.myLocationName;
			
			isGeoReady = true;
		});
	});
	
	$scope.resetParameters = function() {	
		if (gPlacesAutoCompCtrlScope.choosePlace) {
			$scope.contents = [];
			$scope.page = 0;
			eof = false;
//			$scope.keyword = null;
			
			$scope.searchLat = gPlacesAutoCompCtrlScope.details.geometry.location.k;
			$scope.searchLon = gPlacesAutoCompCtrlScope.details.geometry.location.B;
			
			$scope.locationName = gPlacesAutoCompCtrlScope.details.name;
			
			$scope.loadContents($scope.searchLat, $scope.searchLon);
			
			$('#btnSortByDistance').addClass('active');
			$('#btnSortByNewest').removeClass('active');
		} else {
//			$scope.contents = [];
//			$scope.page = 0;
//			eof = false;
//			
//			$scope.loadContents();
			
//			$scope.returnMyLocation();
		}
	};
	
	$scope.returnMyLocation = function() {
		if (isGeoReady) {
			
			gPlacesAutoCompCtrlScope.details = {};
			
			$scope.contents = [];
			$scope.page = 0;
			eof = false;
//			$scope.keyword = null;
			
			$scope.searchLat = $scope.myLat;
			$scope.searchLon = $scope.myLon;
			
			$scope.locationName = $scope.myLocationName;
			
			$scope.loadContents($scope.myLat, $scope.myLon);
			
			$('#btnSortByDistance').addClass('active');
			$('#btnSortByNewest').removeClass('active');
		} else {
			console.log('My location is not ready');
		}
	};
	
	$scope.orderByDate = function() {
		if (isGeoReady) {
			
			$scope.contents = [];
			$scope.page = 0;
			eof = false;
			
			$scope.searchLat = null;
			$scope.searchLon = null;
			
			$scope.loadContents();
			
		} else {
			console.log('My location is not ready');
		}
	};
	
	$scope.orderByNear = function() {
		if (isGeoReady) {
			
			$scope.contents = [];
			$scope.page = 0;
			eof = false;
			
			if (gPlacesAutoCompCtrlScope.details.geometry) {
				$scope.searchLat = gPlacesAutoCompCtrlScope.details.geometry.location.k;
				$scope.searchLon = gPlacesAutoCompCtrlScope.details.geometry.location.B;
			} else {
				$scope.searchLat = $scope.myLat;
				$scope.searchLon = $scope.myLon;
			}
			
			$scope.loadContents($scope.searchLat, $scope.searchLon);
			
		} else {
			console.log('My location is not ready');
		}
	};
	
	$scope.openContent = function(contentId) {
		showContent(contentId);
	};
	
	$scope.showAuthor = function(userId) {
		//TODO
		console.log('Click userId: ' + userId);
	};
	
	function distance(lat1, lon1, lat2, lon2, unit) {
	    var radlat1 = Math.PI * lat1/180
	    var radlat2 = Math.PI * lat2/180
	    var radlon1 = Math.PI * lon1/180
	    var radlon2 = Math.PI * lon2/180
	    var theta = lon1-lon2
	    var radtheta = Math.PI * theta/180
	    var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
	    dist = Math.acos(dist)
	    dist = dist * 180/Math.PI
	    dist = dist * 60 * 1.1515
	    if (unit=="K") { dist = dist * 1.609344 }
	    if (unit=="N") { dist = dist * 0.8684 }
	    return dist
	}
}])

coverFlowApp.directive('scrolling', function() {
	
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
						coverFlowControllerScope.loadContents(coverFlowControllerScope.searchLat, coverFlowControllerScope.searchLon);
					}
		        });
			element.on({
		            'touchmove': function(e) {
		            	if (shouldLoadMore(element, contentPane) && !onCall && !eof) {
							coverFlowControllerScope.loadContents(coverFlowControllerScope.searchLat, coverFlowControllerScope.searchLon);
						}
		            }
		        });
		}
	};
});

coverFlowApp.controller("GPlacesAutoCompCtrl", ['$scope', function ($scope) {
	
	gPlacesAutoCompCtrlScope = $scope;
	
	$scope.result = '';
	$scope.options = null;
	$scope.details = '';
	$scope.choosePlace = false;
}]);