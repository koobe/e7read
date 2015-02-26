$(function() {
	$('.cancel-button').click(function() {
		window.history.back();
	});
	
	$('.btn-select-page-range').click(function() {
		$('.page-range-selector').show(); //.css('display', '');
	});
	
});