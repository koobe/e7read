$(function() {
	
	fitContentHeight('.page-container');
	
	$(window).unbind('resize').resize(function(){
		fitContentHeight('.page-container');
	});
	
	function fitContentHeight(selector) {
		var pageContainer = $(window).height() - $('nav').height() - $('footer').height();
		$(selector).height(pageContainer);
	}
	
	setTimeout(function(){
		$(window).trigger('resize');
	}, 5000);
});