$(function() {
	
//	var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent);
	
	$('.menu-expend-button').addClass('visible-xs-*');
	
	$('.menu-expend-button').click(function() {
		$('.menu-expend-button').addClass('hidden-xs');
		$('.hidden-min').removeClass('hidden-xs');
		$(window).trigger('resize');
	});
	
	$('.menu-hide-button').click(function() {
		$('.menu-expend-button').removeClass('hidden-xs');
		$('.hidden-min').addClass('hidden-xs');
		$(window).trigger('resize');
	});
});