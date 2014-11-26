
var s = $.spinner({fadeTime:100});

var mapWelcomeApp = angular.module('MapWelcomeApp', ['ngResource', 'ngAutocomplete']);

var scopeMapWelcomeMainController;

mapWelcomeApp.controller("MapWelcomeMainController", ['$scope', '$resource', function($scope, $resource) {
	
	scopeMapWelcomeMainController = $scope;
	
	var isReady = false;
	
	$scope.locationName;
	$scope.locationLat;
	$scope.locationLon;
	
	$scope.setLocation = function(lat, lon, name) {
		
		s.loading('設定中 ...');
		
		$scope.locationLat = lat;
		$scope.locationLon = lon;
		
		callGeocodingService(lat, lon, function(locationName) {
			$scope.locationName = locationName;
			s.done();
		});
	}
	
	$scope.setLocationBySensor = function() {
		
		s.loading('正在取得位置資訊 ...');
		
		navigator.geolocation.getCurrentPosition(function(position) {
			var lat = position.coords.latitude;
			var lon = position.coords.longitude;
			
			$scope.locationLat = lat;
			$scope.locationLon = lon;
			
			callGeocodingService(lat, lon, function(locationName) {
				$scope.locationName = locationName;
				s.done();
				isReady = true;
			});
		});
	};
	
	$scope.setLocationByMap = function() {
		var lat = $('input[name=lat]').val();
		var lon = $('input[name=lon]').val();
		console.log('Change location to: ' + lat + ', ' + lon);
		$scope.setLocation(lat, lon, '');
	};
	
	$scope.saveMyLocation = function() {
		if (isReady) {
			s.loading('儲存中 ...');
			console.log('Save my location: ' + $scope.locationLat + ',' + $scope.locationLon);
		}
	};
	
	// pre-loading location from sensor
	$scope.setLocationBySensor();
	
	function callGeocodingService(lat, lon, callback) {
		var GeocodingRestService = $resource('/map/geocoding',{},{
			geocoding: {method:'GET'}
		});
		GeocodingRestService.geocoding({lat:lat, lon:lon}, function(data) {
			var locationName = '';
			if (data.country) {
				locationName = locationName + data.country;
			}
			if (data.city) {
				locationName = locationName + data.city;
			}
			if (data.region) {
				locationName = locationName + data.region;
			}
			callback(locationName);
		});
	}
	
}]);

mapWelcomeApp.controller("GooglePlaceAutoCompleteController", ['$scope', function ($scope) {
	
	$scope.result = '';
	$scope.options = null;
	$scope.details = '';
	$scope.choosePlace = false;
	
	$scope.callback = function() {
		var lat = $scope.details.geometry.location.k;
		var lon = $scope.details.geometry.location.B;
		var name = $scope.details.name;
		scopeMapWelcomeMainController.setLocation(lat, lon, name);
	};
}]);

//$(function() {
//    $('input[name=geolocation]').change(function() {
//    	var lat = $('input[name=lat]').val();
//        var lon = $('input[name=lon]').val();
//        
//    	console.log('Set location: ' + lat + ',' + lon);
//    	
//        scopeMapWelcomeMainController.setLocation(lat, lon, '');
//    });
//});