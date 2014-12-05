/**
 * @license AngularJS v1.3.2
 * 
 */
(function(window, angular, undefined) {'use strict';
	
	var module = angular.module('googleMapService', ['ngResource', 'mapService']);
	
	module.provider('$googleMapService', [function() {
		
		this.$get = ['$resource', '$mapService', function($resource, $mapService) {
			
			function Service() {
				this.map = null;
			}
			
			Service.prototype.defaultMapOption = {
			    zoom: 8,
			    center: new google.maps.LatLng(-34.397, 150.644)
			};
			
			Service.prototype.createMap = function(canvasId, options) {
				var mapOption = {};
				angular.extend(mapOption, this.defaultMapOption, options);
				this.map = new google.maps.Map(document.getElementById(canvasId), mapOption);
				return this.map;
			};
			
			Service.prototype.moveTo = function(lat, lon) {
				var center = new google.maps.LatLng(lat, lon);
				this.map.panTo(center);
			};
			
			Service.prototype.setZoom = function(zoom) {
				this.map.setZoom(zoom);
			};
			
			Service.prototype.getBoundDistance = function() {
				var bounds = this.map.getBounds();
				var northEast = bounds.getNorthEast();
				var southWest = bounds.getSouthWest();
				return $mapService.distance(northEast.k, northEast.B, southWest.k, southWest.B, 'K');
			}
			
			/**
			 * Add map event handler
			 */
			Service.prototype.addMapListener = function(eventName, handler) {
				
				var googlemap = this.map;
				var me = this;
				
				google.maps.event.addListener(googlemap, eventName, function() {
					console.log(me.getBoundDistance());
					handler();
				});
			};
			
			return new Service();
		}];
	}]);

})(window, window.angular);
