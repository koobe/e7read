
/**
 * 
 */

var mapHomeApp = angular.module('MapHomeApp', ['userService', 'mapService', 'searchService', 'googleMapService']);

var onCall = false;
var eof = false;
var isGeoReady = false;

var defaultDistance = 10000;

var scopeContentFlowController;

var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent);

var filterStartDatePicker;
var filterEndDatePicker;

mapHomeApp.controller('ContentFlowController', 
		['$scope', '$mapService', '$userService', '$searchService', '$googleMapService',
		 function($scope, $mapService, $userService, $searchService, $googleMapService) {
	
	var channel = getQueryVariable("channel");
	var categoryName = getQueryVariable("c");
	var s = $.spinner();
	var tip = $.spinner({
		bgColor: 'rgba(148, 230, 218, 0.7)', 
		showIcon: false,
		defaultMsg: 'No more data'});
	
	var priceSliderMax = 0;
	
	$scope.illegalDateSelected = false;
	
	scopeContentFlowController = $scope;
	
	$scope.colXs = 6;
	$scope.colSm = 6;
	$scope.colMd = 4;
	
	$scope.isMapSearch = true;
	
	$scope.myLocation = {};
	$scope.sensorLocation = {};
	$scope.searchLocation = {};
	$scope.lastSearchLocation = {};
	
	$scope.keyword = null;
	$scope.category = categoryName;
	
	if (categoryName) {
		var target = $("a[data-category-name='" + categoryName + "']");
		$scope.categoryName = target.html().trim();
	}
	
	$scope.displayPriceFilter = {};
	
	$scope.extraDateFilter = {};
	$scope.extraPriceFilter = {};
//	$scope.extraPriceFilter = { minPrice:0, maxPrice:0 };
	
	$scope.sortBy = 'distance';
	$scope.extraSortParam = {};
	
	$scope.size = 12;
	$scope.page = 0;
	$scope.contents = [];
	$scope.contentIdList = [];
	
	
	// default search parameters
	var defaultSearchParams = {};
	defaultSearchParams.channel = channel;
	defaultSearchParams.distance = defaultDistance;
	if (categoryName) {
		defaultSearchParams.c = categoryName
	}
	
	$scope.loadContents = function(reset, handler) {
		
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
			$scope.lastSearchLocation.lat = lat;
			$scope.lastSearchLocation.lon = lon;
			$scope.lastSearchLocation.name = $scope.searchLocation.name;
			
			$('#btnSortByDistance').addClass('active');
			$('#btnSortByNewest').removeClass('active');
		} else {
			$scope.locationName = lastName;
		}
		
		$scope.page++;
		var offset = ($scope.page * $scope.size) - $scope.size;
		
		var data = {size: $scope.size, offset: offset, geo: geo, q: $scope.keyword};
		angular.extend(data, defaultSearchParams, $scope.extraSortParam, $scope.extraDateFilter, $scope.extraPriceFilter);
		
		$searchService.searchContent(data, function(contents) {
			
			if (contents.length == 0) {
				console.log('eof');
				eof = true;
			}
			
			angular.forEach(contents, function(content){

				//console.log('--- debug ---');
				content.jsonAttrs = angular.fromJson(content.jsonAttrs);
				//console.log(content.jsonAttrs);

				if (content.jsonAttrs && content.jsonAttrs.tradeType) {
					if (content.jsonAttrs.tradeType == 'buy') {
						if (!$('input[name=tradeType][value=buy]').is(':checked')) {
							return;
						}
					}
					else if (content.jsonAttrs.tradeType == 'sell') {
						if (!$('input[name=tradeType][value=sell]').is(':checked')) {
							return;
						}
					}
				}
				console.log();


				if (geo != null) {
					content.distance = $mapService.distance(lat, lon, content.location.lat, content.location.lon, 'K');
				} else if ($scope.lastSearchLocation.lat && $scope.lastSearchLocation.lon) {
					content.distance = $mapService.distance($scope.lastSearchLocation.lat, $scope.lastSearchLocation.lon, content.location.lat, content.location.lon, 'K');
				}
				
				$scope.contents.push(content);
				$scope.contentIdList.push(content.id);
				
				var iconUrl;
				
				if (content.iconUrl) {
					iconUrl = content.iconUrl;
				} else if (content.categories && content.categories[0]) {
					iconUrl = content.categories[0].iconUrl;
				} else {
					iconUrl = content.channel.iconUrl;
				}
						
				$googleMapService.addMarker(content.location.lat, content.location.lon, {
					contentId: content.id,
					title: content.cropTitle,
					icon: iconUrl
				});
				
//				setTimeout(function(){
				var html = getInfoWindowHTML(content);

				$googleMapService.setInfoWindow({
					contentId: content.id,
					content: html,
					maxWidth: 130
				});
//				}, 300);
					
				if (content.tradingContentAttribute) {
					if (content.tradingContentAttribute.price > priceSliderMax) {
						priceSliderMax = content.tradingContentAttribute.price;
						$( "#slider-price-range" ).slider( "option", "max", priceSliderMax );
						$( "#slider-price-range" ).slider( "option", "values", [0, priceSliderMax] );
					}
				}
				
			});
			
			console.log( $( "#slider-price-range" ).slider( "option", "values") );
			
//			if ($scope.extraPriceFilter.max == 0) {
//				$scope.extraPriceFilter.max = $scope.filterPriceSliderMax;
//			}
			
			onCall = false;
			s.done();
			
			if (handler) {
				handler();
			}
		});
	};
	
//	$scope.orderByDate = function() {
//		if (isGeoReady) {
//			$scope.searchLocation = {};
//			$scope.loadContents(true);
//		}
//	};
	
//	$scope.orderByNear = function() {
//		if (isGeoReady) {
//			$scope.searchLocation = $scope.lastSearchLocation;
//			$scope.loadContents(true);
//		}
//	};
	
	$scope.changeSort = function() {
		if (isGeoReady) {
			if ($scope.sortBy == 'distance') {
				$scope.extraSortParam = {};
				$scope.searchLocation = $scope.lastSearchLocation;
				$scope.loadContents(true);
			} else if ($scope.sortBy == 'newest') {
				$scope.extraSortParam = {};
				$scope.searchLocation = {};
				$scope.loadContents(true);
			} else {
				if ($scope.sortBy == 'price_asc') {
					$scope.extraSortParam = {order: '-price'};
				} else if ($scope.sortBy == 'price_desc') {
					$scope.extraSortParam = {order: 'price'};
				} else {}
				$scope.searchLocation = {};
				$scope.loadContents(true);
			}
		}
	};

	 $scope.refreshAll = function() {
		 console.log('refresh all...');
		 $scope.loadContents(true);
	 };
	
	/**
	 * trigger search action by Enter key
	 */
	$scope.search = function(e) {
		if (e.keyCode == 13) {
			var target = angular.element(e.target);
			searchInput = target;
			
			if (target.val() == null || target.val().trim() == '') {
				$scope.keyword = null;
			} else {
				$scope.keyword = target.val().trim();
			}
			
			$scope.loadContents(true);
			target.blur();
		}
	};
	
	/**
	 * remove search keyword
	 */
	$scope.removeKeyword = function() {
		$('.fulltext-searchbox').val(null);
		$scope.keyword = null;
		$scope.loadContents(true);
	};
	
	$scope.setLocationBySensor = function() {
		
		s.loading('正在取得位置資訊...');
		isGeoReady = false;
		
		$mapService.getCurrentPosition(function(position) {
			
			var lat = position.coords.latitude;
			var lon = position.coords.longitude;
			
			$googleMapService.moveTo(lat, lon);
			$googleMapService.setZoom(13);
			$googleMapService.showCenterCircle();
			
			$mapService.geocoding(lat, lon, function(name) {
				
				$scope.sensorLocation.lat = lat;
				$scope.sensorLocation.lon = lon;
				$scope.sensorLocation.name = name;
				
				s.done();
				isGeoReady = true;
				
				$scope.searchLocation = $scope.sensorLocation;
				$scope.loadContents(true);
			});
		}, function(err) {
			console.log(err);
			var lat = 25.032823891547377;
			var lon = 121.54367807495123;
			
			$googleMapService.moveTo(lat, lon);
			$googleMapService.setZoom(13);
			$googleMapService.showCenterCircle();
			
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
		resetContent();
		
		$userService.getLocation(function(location) {
			var lat = location.lat;
			var lon = location.lon;
			var name = location.name;
			
			if (lat != null && lon != null) {
				$scope.myLocation.lat = lat;
				$scope.myLocation.lon = lon;
				$scope.myLocation.name = name;
				
				$googleMapService.moveTo(lat, lon);
				$googleMapService.setZoom(13);
				$googleMapService.showCenterCircle();
				
				s.done();
				$scope.searchLocation = $scope.myLocation;
				$scope.loadContents(true);
				isGeoReady = true;
			} else {
				if ($scope.sensorLocation.lat) {
					
					$googleMapService.moveTo($scope.sensorLocation.lat, $scope.sensorLocation.lon);
					$googleMapService.showCenterCircle();
					
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
	};
	
	$scope.returnMyLocation = function() {
		if (isGeoReady) {
			$scope.setLocationByUserProfile();
		}
	};
	
	$scope.openContent = function(contentId) {
		showContent(contentId);
	};
	
	$scope.initLocation = function() {
		$scope.setLocationByUserProfile();
	};
	
	$scope.initLocation();
	
	function resetContent() {
		$scope.contents = [];
		$scope.contentIdList = [];
		$scope.page = 0;
//		priceSliderMax = 0;
//		$scope.extraPriceFilter = {};
//		$scope.displayPriceFilter = {};
		eof = false;
	}
	
	$scope.openMapInfoWindow = function(contentId) {
		$googleMapService.openInfoWindow(contentId);
		if (isMobile) {
			$scope.setFullMap();
		}
	};
	
	$scope.setFullMap = function() {
		if (isMobile) {
			$('#map-canvas').show();
			if ($googleMapService.dontloadTimeout) {
				clearTimeout($googleMapService.dontloadTimeout);
			}
			$googleMapService.dontLoad = true;
			$googleMapService.dontloadTimeout = setTimeout(function() {
				$googleMapService.dontLoad = false;
			}, 1000);
		}
		$('#map-canvas').removeClass('col-xs-5');
		$('#map-canvas').addClass('col-xs-12');
		$('#content-canvas').hide();
		$('#full-map').hide();
		$('#half-map').show();
		google.maps.event.trigger($googleMapService.getMap(), 'resize');
	}
	
	$scope.setHalfMap = function() {
		
		if(isMobile) {
			$('#map-canvas').hide();
			$('#content-canvas').removeClass('col-xs-7');
			$('#content-canvas').addClass('col-xs-12');
			$('#content-canvas').show();
			if ($googleMapService.dontloadTimeout) {
				clearTimeout($googleMapService.dontloadTimeout);
			}
			$googleMapService.dontLoad = true;
			$googleMapService.dontloadTimeout = setTimeout(function() {
				$googleMapService.dontLoad = false;
			}, 1000);
		} else {
			$('#map-canvas').addClass('col-xs-5');
			$('#map-canvas').removeClass('col-xs-12');
			google.maps.event.trigger($googleMapService.getMap(), 'resize');
			$('#content-canvas').show();
			$('#full-map').show();
			$('#half-map').hide();
		}
	}
	
	$scope.moveToSearchPoint = function() {
		if ($scope.lastSearchLocation.lat) {
			$googleMapService.moveTo($scope.lastSearchLocation.lat, $scope.lastSearchLocation.lon);
		}
	};
	
	/**
	 * Google map
	 */
	
	
	$googleMapService.createMap('map-canvas', {
		maxZoom: 16,
		minZoom: 5,
		panControl: false,
		streetViewControl: false,
		mapTypeControl: false,
		zoomControlOptions: {style:google.maps.ZoomControlStyle.SMALL},
		
	});
	$googleMapService.addSearchBox('pac-input', {});
	$googleMapService.addMapControl('get-my', google.maps.ControlPosition.RIGHT_TOP);
	$googleMapService.addMapControl('get-current', google.maps.ControlPosition.RIGHT_TOP);
	$googleMapService.addMapControl('return-last', google.maps.ControlPosition.RIGHT_TOP);
	$googleMapService.addMapControl('full-map', google.maps.ControlPosition.RIGHT_BOTTOM);
	$googleMapService.addMapControl('half-map', google.maps.ControlPosition.RIGHT_BOTTOM);
	$googleMapService.addMapControl('is-search', google.maps.ControlPosition.TOP_RIGHT);
	
	$googleMapService.addSearchBoxListener('place_changed', function() {
		triggerMapReload();
	});
	
	if(isMobile) {
		$googleMapService.addMapListener('idle', function() {
			if (!$googleMapService.dontLoad) {
				if ($scope.isMapSearch) {
					triggerMapReload();
				}
			}
		});
		$scope.setFullMap();
	} else {
		$googleMapService.addMapListener('dragend', function() {
			if ($scope.isMapSearch) {
				triggerMapReload();
			}
		});
	}
	
	$scope.nextInfoWindow = function() {
		var idx = $scope.contentIdList.indexOf($googleMapService.getLastOpenContentId());
		var nextIdx = idx + 1;
		if (nextIdx == $scope.contentIdList.length) {
			if (!eof) {
				$scope.loadContents(false, function() {
					console.log(eof);
					if (!eof) {
						var nextContentId = $scope.contentIdList[nextIdx];
						$googleMapService.openInfoWindow(nextContentId);
					} else {
						tip.show();
						setTimeout(function() {
							tip.hide();
						}, 2000);
					}
				});
			} else {
				tip.show();
				setTimeout(function() {
					tip.hide();
				}, 2000);
			}
		} else {
			var nextContentId = $scope.contentIdList[nextIdx];
			$googleMapService.openInfoWindow(nextContentId);
		}
	};
	
	$scope.prevInfoWindow = function() {
		var idx = $scope.contentIdList.indexOf($googleMapService.getLastOpenContentId());
		var prevIdx = idx - 1;
		if (prevIdx == -1) {
			tip.show();
			setTimeout(function() {
				tip.hide();
			}, 2000);
		} else {
			var prevContentId = $scope.contentIdList[prevIdx];
			$googleMapService.openInfoWindow(prevContentId);
		}
	};
	
	function triggerMapReload() {
		if (isGeoReady) {
			var lat = $googleMapService.getMap().getCenter().lat();
			var lon = $googleMapService.getMap().getCenter().lng();
//			defaultSearchParams.distance = $googleMapService.getBoundDistance();
			$scope.searchLocation = {lat: lat, lon: lon, name: ''};
			$scope.loadContents(true);
			$googleMapService.showCenterCircle();
			$googleMapService.closeCurrentInfoWindow();
		}
	}
	
	$scope.clearDateFilter = function() {
		$("#start-date").datepicker( "setDate", null );
		$("#end-date").datepicker( "setDate", null );
		$scope.extraDateFilter = {};
		$scope.loadContents(true);
	};
	
	var filterDatePickerHandler = function() {
		var startTime = $("#start-date").datepicker("getDate")? $("#start-date").datepicker("getDate").getTime(): null;
		var endTime = $("#end-date").datepicker("getDate")? $("#end-date").datepicker("getDate").getTime(): null;
		
		if (startTime && endTime) {
		
			endTime = endTime + (24 * 60 * 60 * 1000);
			
			if (startTime < endTime) {
				console.log("select start time: " + startTime);
				console.log("select end time: " + endTime);
				$scope.illegalDateSelected = false;
				$scope.extraDateFilter = {
					dateFilterStart: startTime,
					dateFilterEnd: endTime
				};
				$scope.$apply();
				$scope.loadContents(true);
			} else {
				console.log("Illegal selected date");
				$scope.illegalDateSelected = true;
				$scope.$apply();
			}
		}
		
	};
	filterStartDatePicker = $('#start-date').datepicker({
		onSelect: filterDatePickerHandler,
		beforeShow: function() {
	        setTimeout(function(){
	            $('.ui-datepicker').css('z-index', 399);
	        }, 0);
	    }
	});
	filterEndDatePicker = $('#end-date').datepicker({
		onSelect: filterDatePickerHandler,
		beforeShow: function() {
	        setTimeout(function(){
	            $('.ui-datepicker').css('z-index', 399);
	        }, 0);
	    }
	});
	
	$scope.clearPriceFilter = function() {
		$scope.displayPriceFilter = {};
		$scope.extraPriceFilter = {};
		$scope.loadContents(true);
	};
	
	$( "#slider-price-range" ).slider({
	      range: true,
	      min: 0,
	      max: 0,
	      values: [ 0, 0 ],
	      slide: function(event, ui) {
	    	  $scope.displayPriceFilter.min = ui.values[0];
	    	  $scope.displayPriceFilter.max = ui.values[1];
	    	  $scope.$apply();
	      },
	      stop: function(event, ui) {
	    	  $scope.extraPriceFilter = { minPrice: ui.values[0], maxPrice: ui.values[1] };
	    	  $scope.loadContents(true);
	      }
    });
	
	
	function getInfoWindowHTML(content) {

		console.log(content);

		var container = $('<div class="container"/>');
		
		var imgContainer = $('<div class="div-bg-thumbnail-cover info-window-image" onclick="showContent(\'' + content.id + '\')"/>');
		imgContainer.css('background-image', 'url(' + content.coverUrl + ')');
		imgContainer.css('cursor', 'pointer');
		
		var titleContainer = $('<div class="info-window-title" />');
		var title = $('<span/>').html(content.cropTitle);
		titleContainer.append(title);

		var separator = $('<div class="info-window-separator" />');
		
		var infoContainer = $('<div class="info-window-info" />');
		
		var author = $('<div><i class="fa fa-user"></i> <span>' + content.user.fullName + '</span><div/>');
		
		var milliseconds = Date.parse(content.datePosted);
		var datePosted = new Date(milliseconds);
		var date = $('<div><i class="fa fa-clock-o"></i> <span>' + datePosted.getFullYear() + '/' + (datePosted.getMonth()+1) + '/' + datePosted.getDate() + '</span></div>');
		
//		var distance = $('<div><i class="fa fa-car"></i> <span>' + (Math.round(content.distance*100)/100) + ' 公里</span><div/>');
		
		infoContainer.append(author).append(date); //.append(distance);


		if (content.jsonAttrs && content.jsonAttrs.tradeType) {
			//console.log('----mmmmmm-----');
			//console.log(content.jsonAttrs.tradeType);
			if (content.jsonAttrs.tradeType == 'sell') {
				infoContainer.append('<div style="text-align: center"><span class="label label-success">\n<i class="fa fa-tag"></i>\nSell</span></div>');
			}
			else if (content.jsonAttrs.tradeType == 'buy') {
				infoContainer.append('<div style="text-align: center"><span class="label label-success">\n<i class="fa fa-shopping-cart"></i>\nBuy</span></div>');
			}
		}


		var separatorDashed = $('<div class="info-window-separator-dashed" />');
		
		var navigatorDiv = $('<div/>');
		navigatorDiv.css('padding-top', '5px');
		
		var leftBtn = $('<a href="javascript: openedWindowPrevContent();" class="btn btn-default btn-circle"><i class="fa fa-caret-left"></i></a>');
		var rightBtn = $('<a href="javascript: openedWindowNextContent();" class="btn btn-default btn-circle"><i class="fa fa-caret-right"></i></a>');
		rightBtn.css('float', 'right');
		
		navigatorDiv.append(leftBtn).append(rightBtn);
		
		container.append(imgContainer).append(titleContainer).append(separator).append(infoContainer).append(navigatorDiv);
		
		return container.html();
	}
	
}]);


mapHomeApp.directive('scrolling', function() {
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
						scopeContentFlowController.loadContents();
					}
		        });
			element.on({
		            'touchmove': function(e) {
		            	if (shouldLoadMore(element, contentPane) && !onCall && !eof) {
		            		scopeContentFlowController.loadContents();
						}
		            }
		        });
		}
	};
});

function openedWindowNextContent() {
	scopeContentFlowController.nextInfoWindow();
}

function openedWindowPrevContent() {
	scopeContentFlowController.prevInfoWindow();
}