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
				this.markerMap = {};
				this.markerInfoWindow = {};
				this.markerInitZIndex = 5;
			}
			
			Service.prototype.defaultMapOption = {
			    zoom: 8,
			    center: new google.maps.LatLng(-34.397, 150.644)
			};
			
			Service.prototype.getMap = function() {
				return this.map;
			};
			
			Service.prototype.createMap = function(canvasId, options) {
				var mapOption = {};
				angular.extend(mapOption, this.defaultMapOption, options);
				this.map = new google.maps.Map(document.getElementById(canvasId), mapOption);
				return this.map;
			};
			
			/**
			 * Add google places search box
			 */
			Service.prototype.addSearchBox = function(inputId, options) {
				
				var input = document.getElementById(inputId);
				
				this.addMapControl(inputId, google.maps.ControlPosition.TOP_LEFT);
				
				var autocomplete = new google.maps.places.Autocomplete(input, options);
				this.autocomplete = autocomplete;
				
				var me = this;
				google.maps.event.addListener(autocomplete, 'place_changed', function() {
					var place = autocomplete.getPlace();
					if (place && place.geometry && place.geometry.location) {
						me.moveTo(place.geometry.location.k, place.geometry.location.B);
						me.setPlaceMarker(place.geometry.location.k, place.geometry.location.B, {});
					}
				});
			};
			
			/**
			 * Add map control
			 */
			Service.prototype.addMapControl = function(id, position) {
				var control = document.getElementById(id);
				this.map.controls[position].push(control);
			};
			
			/**
			 * Add search box listener
			 */
			Service.prototype.addSearchBoxListener = function(eventName, handler) {
				var me = this;
				google.maps.event.addListener(this.autocomplete, eventName, function() {
					var place = me.autocomplete.getPlace();
					if (place && place.geometry && place.geometry.location) {
						handler();
					}
				});
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
				google.maps.event.addListener(this.map, eventName, function() {
					handler();
				});
			};
			
			Service.prototype.addMarker = function(lat, lon, options) {
				
				if (!this.markerMap[options.contentId]) {
					var markerLatLng = new google.maps.LatLng(lat, lon);
					
					var markerIcon = {
						url: options.icon,
						size: new google.maps.Size(38, 38),
						scaledSize: new google.maps.Size(38, 38)
					};
					
					angular.extend(options, {
						map: this.map, 
						position: markerLatLng,
						animation: google.maps.Animation.DROP,
						icon: markerIcon,
					});
					
					// add to cache map
					this.markerMap[options.contentId] = new google.maps.Marker(options);
				}
			};
			
			/**
			 * Set place marker
			 */
			Service.prototype.setPlaceMarker = function(lat, lon, options) {
				
				if (this.placeMarker) {
					this.placeMarker.setMap(null);
				}
				
				var markerLatLng = new google.maps.LatLng(lat, lon);
				
				var markerIcon = {
					url: '/assets/map/marker.png',
					size: new google.maps.Size(23, 32),
					scaledSize: new google.maps.Size(23, 32)
				};
				
				angular.extend(options, {
					map: this.map, 
					position: markerLatLng,
					animation: google.maps.Animation.DROP,
					icon: markerIcon,
				});
				
				this.placeMarker = new google.maps.Marker(options);
			};
			
			/**
			 * Add info window, will attach with contentId in option
			 */
			Service.prototype.setInfoWindow = function(options) {
				
				if (!this.markerInfoWindow[options.contentId]) {
					var attachMarker = this.markerMap[options.contentId];
					var googlemap = this.map;
					var me = this;
					if (attachMarker) {
						
						var infoWindow = new google.maps.InfoWindow(options);
						this.markerInfoWindow[options.contentId] = infoWindow;
							
						google.maps.event.addListener(attachMarker, 'click', function() {
							me.openInfoWindow(options.contentId);
		                });
					}
				}
			};
			
			/**
			 * open info window by contentId
			 */
			Service.prototype.openInfoWindow = function(contentId) {
				var marker = this.markerMap[contentId];
				this.markerInfoWindow[contentId].open(this.map, marker);
				marker.setAnimation(google.maps.Animation.BOUNCE);
				this.opendInfoWindow = this.markerInfoWindow[contentId];
				
				for (var key in this.markerInfoWindow) {
					if (contentId != key) {
						this.markerInfoWindow[key].close();
						this.markerMap[key].setAnimation(null);
					}
				}
				
				this.topMarkerZIndex(contentId);
			};
			
			Service.prototype.closeCurrentInfoWindow = function() {
				if (this.opendInfoWindow) {
					this.opendInfoWindow.close();
				}
			};
			
			Service.prototype.topMarkerZIndex = function(contentId) {
				var marker = this.markerMap[contentId];
				marker.setZIndex(this.markerInitZIndex++);
			};
			
			Service.prototype.showCenterCircle = function() {
				
				if (this.centerCircle) {
					this.centerCircle.setMap(null);
				}
				if (this.centerCircleInside) {
					this.centerCircleInside.setMap(null);
				}
				
				this.centerCircle = new google.maps.Marker({
					position: this.map.getCenter(),
					icon: {
					    path: google.maps.SymbolPath.CIRCLE,
					    fillOpacity: 0.5,
					    fillColor: 'rgb(116, 165, 188)',
					    strokeOpacity: 0.8,
					    strokeColor: 'rgb(116, 165, 188)',
					    strokeWeight: 1, 
					    scale: 20 //pixels
					},
					map: this.map
				});
				
				this.centerCircleInside = new google.maps.Marker({
					position: this.map.getCenter(),
					icon: {
					    path: google.maps.SymbolPath.CIRCLE,
					    fillOpacity: 0.9,
					    fillColor: 'rgb(66, 134, 247)',
						strokeOpacity: 1.0,
						strokeColor: 'rgb(255, 255, 255)',
						strokeWeight: 1, 
						scale: 7 //pixels
					},
					map: this.map
				});
			};
			
			
			return new Service();
		}];
	}]);

})(window, window.angular);
