$(function() {
	
//	var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent);
	
	var isIPad = /iPad/i.test(navigator.userAgent);
	
	$('.menu-expend-button').addClass('visible-xs-*');
	
	if (isIPad) {
		$('.menu-expend-button').css("display", "none");
		$('.menu-hide-button').css("display", "none");
		$('.hidden-min').removeClass('hidden-xs');
		$('.hidden-min').removeAttr("style");
		$(window).trigger('resize');
	}
	
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