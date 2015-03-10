$(function() {
	
	$('.category-link-item').attr('href', 'javascript:void(0);');
	$('.category-link-item').click(function(e) {
		var target = e.target;
		var category = $(target).data('category');
		window.location.href = '/home/list?c=' + category;
	});
	
	$('.gotocategorylink').attr('href', 'javascript:void(0);');
	$('.gotocategorylink').click(function(e) {
		var target = e.target;
		var category = $(target).data('categoryName');
		window.location.href = '/home/list?c=' + category;
	});
});