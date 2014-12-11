$(function() {
	
//	var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent);
	
	var isIPad = /iPhone|iPad|iPod/i.test(navigator.userAgent);
	
	$('.menu-expend-button').addClass('visible-xs-*');
	
	var after = $('<div/>');
	if (!isIPad) {
		$('nav').css("position", "absolute");
		$('nav').css("top", "0px");
		$('nav').css("left", "0px");
		$('nav').css("width", "100%");
		$('nav').css("background-color", "#FAF8F5");
		$('nav').css("z-index", "10");
		after.height($('nav').height());
		$('nav').after(after);
	}
	
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
		after.height($('nav').height());
	});
	
	$('.menu-hide-button').click(function() {
		$('.menu-expend-button').removeClass('hidden-xs');
		$('.hidden-min').addClass('hidden-xs');
		$(window).trigger('resize');
		after.height($('nav').height());
	});
});