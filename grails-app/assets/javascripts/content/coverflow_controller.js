var channel = getQueryVariable("channel");
var categoryName = getQueryVariable("c");

var coverFlowApp = angular.module('coverFlowApp', ['ngResource']);

coverFlowApp.config(function($provide, $compileProvider, $filterProvider) {
	
});

var s = $.spinner();

var coverFlowControllerScope;
var onCall = false;
var eof = false;

coverFlowApp.controller('CoverFlowController', ['$scope', '$resource', '$log', function($scope, $resource, $log) {
	
	coverFlowControllerScope = $scope;
	
	var params = {};
	params.channel = channel;
	if (categoryName) {
		params.c = categoryName
	}
	
	var SearchContentRestService = $resource('/search/contents', {}, {
		search: {method:'GET', params:params, isArray: true}
	});
	
	$scope.size = 12;
	$scope.page = 0;
	
	$scope.contents = [];
	
	$scope.loadMore = function() {
		$log.log('load more... ' + $scope.page + ', ' + $scope.size);
		onCall = true;
		
		s.loading();
		
		$scope.page++;
		var offset = ($scope.page * $scope.size) - $scope.size;
		
		SearchContentRestService.search({size: $scope.size, offset: offset}, function(contents){
			if (contents.length == 0) {
				eof = true;
			}
			angular.forEach(contents, function(content){
				$scope.contents.push(content);
			});
			
			onCall = false;
			s.done();
		});
	};
	
	$scope.loadMore();
	
	$scope.openContent = function(target, contentId) {
		console.log(target);
		showContent(contentId);
	};
	
	$scope.showAuthor = function(target, userId) {
		console.log(target);
		console.log(userId);
	};
}])

coverFlowApp.directive('scrolling', function() {
	
	function isLoadMore(scrollingObj, contentObj) {
		var factor = scrollingObj.scrollTop() + scrollingObj.height() + 100;
		
		if ((contentObj.height() - factor) <= 0) {
	        return true;
	    } else {
	    	return false;
	    }
	}
	
	return {
		restrict: 'A',
		link: function(scope, elem, attrs) {
			
			var contentPane = $('.content-pane', elem);
			
			elem.scroll(function() {
					if (isLoadMore(elem, contentPane) && !onCall && !eof) {
						coverFlowControllerScope.loadMore();
					}
		        });
		    elem.on({
		            'touchmove': function(e) {
		            	if (isLoadMore(elem, contentPane) && !onCall && !eof) {
							coverFlowControllerScope.loadMore();
						}
		            }
		        });
		}
	};
});