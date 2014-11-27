/**
 * @license AngularJS v1.3.2
 * @author cloude
 */
(function(window, angular, undefined) {'use strict';
	
	var module = angular.module('searchService', ['ngResource']);
	
	module.provider('$searchService', [function() {
		
		this.$get = ['$resource', function($resource) {
			
			function Service() {}
			
			Service.prototype.searchContent = function(params, callback) {
				var service = $resource('/search/contents', {}, {
					search: {method:'GET', params:params, isArray: true}
				});
				service.search(params, function(contents) {
					callback(contents);
				});
			};
			
			return new Service();
		}];
	}]);

})(window, window.angular);
