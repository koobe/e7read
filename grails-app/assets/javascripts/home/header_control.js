$(function() {
	
//	var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent);
	
	$('.menu-expend-button').click(function() {
		$('.hidden-max').hide();
		$('.hidden-min').removeClass('hidden-xs');
	});
	
	$('.menu-hide-button').click(function() {
		$('.hidden-max').show();
		$('.hidden-min').addClass('hidden-xs');
		$(window).trigger('resize');
	});
	
});