$(function() {
	
	fitContentHeight('.page-container');
	
	$(window).unbind('resize').resize(function(){
		fitContentHeight('.page-container');
	});
	
	function fitContentHeight(selector) {
		var pageContainer = $(window).height() - $('nav').height() - $('footer').height();
		$(selector).height(pageContainer);
	}
	
	
	var elm = $('<input id="pac-input" class="controls" type="text" placeholder="Search Box" style="">');
});