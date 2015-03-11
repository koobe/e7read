
var richHomeApp = angular.module('RichHomeApp', ['userService', 'mapService', 'categoryService', 'searchService']);

richHomeApp.controller('RichHomeController', 
	['$scope', '$mapService', '$userService', '$categoryService', '$searchService',
	 	function($scope, $mapService, $userService, $categoryService, $searchService) {
		
			var channel = getQueryVariable("channel");
		
			$scope.defaultPanelColors = ['#EFAF7F', '#B34735', '#3F579F'];
			$scope.initCols = [6, 5, 7, 12];
			
			$scope.initOffset = [0, 7, 14, 20];
		
			$scope.categories = [];
			$scope.categoryContents = {};
			$scope.slideshowContents = [];
			
			var rnd_offset = Math.floor((Math.random() * 4));
			var req_data = {
				size: 5, 
				offset: rnd_offset,
				channel: channel
			};
			
			$searchService.searchContent(req_data, function(contents) {
				
				var idx = 0;
				
				angular.forEach(contents, function(content) {
					
					if (idx == 0) {
						content.isFirst = true;
					}
					
					idx++;
					
					$scope.slideshowContents.push(content);
				});
				
			});
			
			$categoryService.list(function(categorys) {
				
				var categoryList = [];
				var categoryCount = 0;
				
				angular.forEach(categorys, function(category) {
					
					categoryCount++;
					
					var displayName = $("a[data-category-name='"+category.name+"']").html();
					category.displayName = displayName.trim();
					category.headerBgColorIdx = Math.floor((Math.random() * 3));
					category.cols = 6;
//					if ((categorys.length % 2) == 1 && categoryCount == categorys.length) {
//						category.cols = 12;
//					}
					
					var req_data = {
						size: 6, 
						offset: 0,
						channel: channel,
						c: category.name
					};
					
					$searchService.searchContent(req_data, function(contents) {
						
						var contentList = [];
						var first_in_row = true;
						var last_cols_size = 0;
						
						if (contents.length != 0) {
							categoryList.push(category);
						}
						
						angular.forEach(contents, function(content) {
							
							if (first_in_row) {
								var rnd_idx = Math.floor((Math.random() * 3));
								last_cols_size = $scope.initCols[rnd_idx];
								content.cols = last_cols_size;
								first_in_row = false;
							} else {
								if (last_cols_size == 12) {
									var rnd_idx = Math.floor((Math.random() * 3));
									content.cols = $scope.initCols[rnd_idx];
								} else {
									content.cols = 12 - last_cols_size;
								}
								first_in_row = true;
							}
							
							var left_right = Math.floor((Math.random() * 2));
							content.imageSide = left_right;
							
							var stamp = new Date().getTime();
							content.stamp = stamp;
							
							contentList.push(content);
						});
						
						$scope.categoryContents[category.name] = contentList;
					});
						
				});
				
				$scope.categories = categoryList;
			});
			
			var timerMap = {};
			
			$scope.mouseoverBlock = function(categoryName, contentId, stamp) {
				$('#marquee-' + contentId + stamp).css('display', 'block');
				$('#title-' + contentId + stamp).css('display', 'none');
				
				
				
				if (!timerMap[contentId + stamp]) {
					
					var content;
					var contentList = $scope.categoryContents[categoryName];
					
					angular.forEach(contentList, function(contentObj) {
						if (contentObj.id == contentId) {
							content = contentObj;
						}
					});
					
					var pictureSize = content.pictureSegments.length;
					var idx = 0;
					
					var timer = setInterval(function() {
						idx++;
						if (idx >= pictureSize) {
							idx = 0;
						}
						
						var imageUrl = content.pictureSegments[idx].thumbnailUrl;
						if (!imageUrl) {
							imageUrl = content.pictureSegments[idx].originalUrl;
						}
						
						$('.image-' + contentId + stamp).css('background-image', 'url(' + imageUrl + ')');
						
					}, 2000);
					
					timerMap[contentId + stamp] = timer;
				}
				
			};
			
			$scope.mouseoverLeave = function(categoryName, contentId, stamp) {
				$('#marquee-' + contentId + stamp).css('display', 'none');
				$('#title-' + contentId + stamp).css('display', 'block');
				
				if (timerMap[contentId + stamp] != null) {
					clearInterval(timerMap[contentId + stamp]);
					timerMap[contentId + stamp] = null;
				}
				
			};
			
			$scope.openContent = function(contentId) {
				showContent(contentId);
			};
			
			$scope.search = function(e) {
				if (e.keyCode == 13) {
					var target = angular.element(e.target);
					
					if (target.val() == null || target.val().trim() == '') {
					} else {
						window.location.href = '/home/list?q=' + target.val().trim();
					}
				}
			}
		
		}
	]
);