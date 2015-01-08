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
	
	var isFilterPanelOpend = false;
	
	$('.extended-filter-panel-click').click(function() {
		if (isFilterPanelOpend) {
			$('.extended-filter-panel').hide(250);
			isFilterPanelOpend = false;
			$('#icon-filter-toggle').removeClass('fa-caret-up').addClass('fa-tasks');
		} else {
			$('.extended-filter-panel').show(250);
			isFilterPanelOpend = true;
			$('#icon-filter-toggle').removeClass('fa-tasks').addClass('fa-caret-up');
		}
	});
	
});