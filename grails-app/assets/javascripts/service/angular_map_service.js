/**
 * @license AngularJS v1.3.2
 * 
 */
(function(window, angular, undefined) {'use strict';
	
	var module = angular.module('mapService', ['ng', 'ngResource']);
	
	module.provider('$mapService', [function() {
		
		this.$get = ['$resource', function($resource) {
			
			function Service() {}
			
			Service.prototype.geocoding = function(lat, lon, callback) {
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
			
			return new Service();
		}];
	}]);

})(window, window.angular);
