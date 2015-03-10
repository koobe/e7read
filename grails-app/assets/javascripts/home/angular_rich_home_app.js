
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
				
				angular.forEach(categorys, function(category) {
					
					var displayName = $("a[data-category-name='"+category.name+"']").html();
					category.displayName = displayName.trim();
					category.headerBgColorIdx = Math.floor((Math.random() * 3));
					
					
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
			
			$scope.mouseoverBlock = function(contentIdStamp) {
				$('#marquee-' + contentIdStamp).css('display', 'block');
				$('#title-' + contentIdStamp).css('display', 'none');
			};
			
			$scope.mouseoverLeave = function(contentIdStamp) {
				$('#marquee-' + contentIdStamp).css('display', 'none');
				$('#title-' + contentIdStamp).css('display', 'block');
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