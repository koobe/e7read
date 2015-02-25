$(function() {
	$('.publisher-row').click(function(e) {
		var target = $(e.target);
		var publisherId = target.data('publisherid');
		if (!publisherId) {
			publisherId = target.parent().data('publisherid');
		}
		if (publisherId) {
			window.location.href = '/bookAdmin/publisher/' + publisherId;
		}
	});
});