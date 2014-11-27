/**
 * @license AngularJS v1.3.2
 * 
 */
(function(window, angular, undefined) {'use strict';
	
	var module = angular.module('userService', ['ngResource']);
	
	module.provider('$userService', [function() {
		
		this.$get = ['$resource', function($resource) {
			
			function Service() {}
			
			Service.prototype.getLocation = function(callback) {
				var service = $resource('/user/getLocation');
				service.get({}, function(location) {
					callback(location);
				});
			};
			
			Service.prototype.setLocation = function(lat, lon, callback) {
				var service = $resource('/user/setLocation',{},{
					setLocation: {method:'GET'}
				});
				service.setLocation({lat: lat, lon: lon}, function() {
					callback();
				});
			};
			
			Service.prototype.skipSetLocation = function(callback) {
				var service = $resource('/user/skipSetLocation',{},{
					skipSetLocation: {method:'GET'}
				});
				service.skipSetLocation({}, function() {
					callback();
				});
			};
			
			return new Service();
		}];
	}]);

})(window, window.angular);
