/**
 * @license AngularJS v1.3.2
 * @author cloude
 */
(function(window, angular, undefined) {'use strict';
	
	var module = angular.module('categoryService', ['ngResource']);
	
	module.provider('$categoryService', [function() {
		
		this.$get = ['$resource', function($resource) {
			
			function Service() {}
			
			Service.prototype.list = function(params, callback) {
				var service = $resource('/category/list', {}, {
					list: {method:'GET', params:params, isArray: true}
				});
				service.list(params, function(categorys) {
					callback(categorys);
				});
			};
			
			return new Service();
		}];
	}]);

})(window, window.angular);
