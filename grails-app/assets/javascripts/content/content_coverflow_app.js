var channel = getQueryVariable("channel");
var categoryName = getQueryVariable("c");

var coverFlowApp = angular.module('coverFlowApp', ['ngAutocomplete', 'userService', 'mapService', 'searchService']);

var s = $.spinner();

var scopeCoverFlowController;
var scopeGPlacesAutoCompController;
var onCall = false;
var eof = false;
var isGeoReady = false;

var defaultDistance = 10000;

coverFlowApp.controller('CoverFlowController', ['$scope', '$mapService', '$userService', '$searchService', 
                                                function($scope, $mapService, $userService, $searchService) {
	
	scopeCoverFlowController = $scope;
	
	var searchInput;

	// default search parameters
	var defaultSearchParams = {};
	defaultSearchParams.channel = channel;
	defaultSearchParams.distance = defaultDistance;
	if (categoryName) {
		defaultSearchParams.c = categoryName
	}
	
	$scope.myLocation = {};
	$scope.sensorLocation = {};
	$scope.searchLocation = {};
	
	$scope.locationName;
	
	$scope.keyword = null;
	$scope.category = categoryName;
	
	if (categoryName) {
		var target = $("a[data-category-name='" + categoryName + "']");
		$scope.categoryName = target.html().trim();
	}
	
	$scope.size = 12;
	$scope.page = 0;
	$scope.contents = [];
	
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
			});
			onCall = false;
			s.done();
		});
	};
	
	/**
	 * trigger search action by Enter key
	 */
	$scope.search = function(e) {
		if (e.keyCode == 13) {
			var target = angular.element(e.target);
			searchInput = target;
			
			resetContent();
			
			if (target.val() == null || target.val().trim() == '') {
				$scope.keyword = null;
			} else {
				$scope.keyword = target.val().trim();
			}
			
			$scope.loadContents($scope.searchLat, $scope.searchLon);
			target.blur();
		}
	}
	
	/**
	 * remove search keyword
	 */
	$scope.removeKeyword = function() {
		searchInput.val(null);
		$scope.keyword = null;
		$scope.loadContents(true);
	}
	
	$scope.setLocationBySensor = function() {
		
		s.loading('正在取得位置資訊...');
		isGeoReady = false;
		
		$mapService.getCurrentPosition(function(position) {
			
			var lat = position.coords.latitude;
			var lon = position.coords.longitude;
			
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
		$userService.getLocation(function(location) {
			var lat = location.lat;
			var lon = location.lon;
			var name = location.name;
			
			if (lat != null && lon != null) {
				$scope.myLocation.lat = lat;
				$scope.myLocation.lon = lon;
				$scope.myLocation.name = name;
				
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
	
	/**
	 * return to my location
	 */
	$scope.returnMyLocation = function() {
		if (isGeoReady) {
			$scope.setLocationByUserProfile();
			$('#btnSortByDistance').addClass('active');
			$('#btnSortByNewest').removeClass('active');
		} else {
			console.log('My location is not ready');
		}
	};
	
	$scope.lastSearchLocation = {};
	
	$scope.orderByDate = function() {
		if (isGeoReady) {
			$scope.lastSearchLocation.lat = $scope.searchLocation.lat;
			$scope.lastSearchLocation.lon = $scope.searchLocation.lon;
			$scope.lastSearchLocation.name = $scope.searchLocation.name;
			$scope.searchLocation = {};
			$scope.loadContents(true);
		} else {
			console.log('My location is not ready');
		}
	};
	
	$scope.orderByNear = function() {
		if (isGeoReady) {
			$scope.searchLocation = $scope.lastSearchLocation;
			$scope.loadContents(true);
		} else {
			console.log('My location is not ready');
		}
	};
	
	$scope.searchSelectedLocation = function(details) {
		console.log(details);
		
		$scope.searchLocation.lat = details.geometry.location.k;
		$scope.searchLocation.lon = details.geometry.location.B;
		$scope.searchLocation.name = details.name;
		$scope.loadContents(true);
		
		$('#btnSortByDistance').addClass('active');
		$('#btnSortByNewest').removeClass('active');
	};
	
	$scope.openContent = function(contentId) {
		showContent(contentId);
	};
	
	$scope.showAuthor = function(userId) {
		//TODO
		console.log('Click userId: ' + userId);
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
}])

coverFlowApp.directive('scrolling', function() {
	
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
						scopeCoverFlowController.loadContents();
					}
		        });
			element.on({
		            'touchmove': function(e) {
		            	if (shouldLoadMore(element, contentPane) && !onCall && !eof) {
		            		scopeCoverFlowController.loadContents();
						}
		            }
		        });
		}
	};
});

coverFlowApp.controller("GPlacesAutoCompController", ['$scope', function ($scope) {
	
	scopeGPlacesAutoCompController = $scope;
	
	$scope.result = '';
	$scope.options = null;
	$scope.details = '';
	$scope.choosePlace = false;
	
	$scope.callback = function() {
		if ($scope.choosePlace) {
			$scope.searchSelectedLocation($scope.details);
		}
	}
}]);