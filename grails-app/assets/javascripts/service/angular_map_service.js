/**
 * @license AngularJS v1.3.2
 * 
 */
(function(window, angular, undefined) {'use strict';
	
	var module = angular.module('mapService', ['ngResource']);
	
	module.provider('$mapService', [function() {
		
		this.$get = ['$resource', function($resource) {
			
			function Service() {}
			
			Service.prototype.getCurrentPosition = function(callback, errorCallback) {
				navigator.geolocation.getCurrentPosition(function(position) {
					callback(position);
				}, errorCallback, {timeout:7000});
			};
			
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
			};
			
			Service.prototype.distance = function(lat1, lon1, lat2, lon2, unit) {
			    var radlat1 = Math.PI * lat1/180;
			    var radlat2 = Math.PI * lat2/180;
			    var radlon1 = Math.PI * lon1/180;
			    var radlon2 = Math.PI * lon2/180;
			    var theta = lon1-lon2;
			    var radtheta = Math.PI * theta/180;
			    var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
			    dist = Math.acos(dist);
			    dist = dist * 180/Math.PI;
			    dist = dist * 60 * 1.1515;
			    if (unit=="K") { dist = dist * 1.609344 }
			    if (unit=="N") { dist = dist * 0.8684 }
			    return dist
			};
			
			return new Service();
		}];
	}]);

})(window, window.angular);
