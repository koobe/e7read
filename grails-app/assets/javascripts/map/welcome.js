/**
 * @license AngularJS v1.3.2
 * @author cloude
 */

var s = $.spinner({fadeTime:100});

var mapWelcomeApp = angular.module('MapWelcomeApp', ['ngAutocomplete', 'mapService', 'userService']);

var scopeMapWelcomeMainController;

mapWelcomeApp.controller("MapWelcomeMainController", ['$scope', '$mapService', '$userService', 
                                              function($scope, $mapService, $userService) {
	
	scopeMapWelcomeMainController = $scope;
	
	var isReady = false;
	
	$scope.locationName;
	$scope.locationLat;
	$scope.locationLon;
	
	$scope.setLocation = function(lat, lon, name) {
		
		s.loading('設定中 ...');
		
		$scope.locationLat = lat;
		$scope.locationLon = lon;
		
		$mapService.geocoding(lat, lon, function(locationName) {
			$scope.locationName = locationName;
			s.done();
			isReady = true;
		});
	}
	
	$scope.setLocationBySensor = function() {
		
		s.loading('正在取得位置資訊 ...');
		
		$mapService.getCurrentPosition(function(position) {
			var lat = position.coords.latitude;
			var lon = position.coords.longitude;
			$scope.locationLat = lat;
			$scope.locationLon = lon;
			
			$mapService.geocoding(lat, lon, function(locationName) {
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
			$userService.setLocation($scope.locationLat, $scope.locationLon, function() {
				window.location.replace("/");
			});
		}
	};
	
	$scope.skipSetLocation = function() {
		$userService.skipSetLocation(function() {
			window.location.replace("/");
		});
	};
	
	$scope.openPromptMap = function() {
//		window.open('/map/prompt?center=' + $scope.locationLat + ',' + $scope.locationLon, '_blank');
		window.open('/map/prompt', '_blank');
	};
	
	// pre-loading location from sensor
	$scope.setLocationBySensor();
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