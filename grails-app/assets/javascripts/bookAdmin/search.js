$(function() {
	$('.input-search').keypress(function(e) {
		if (event.which == 13) {
			var q = $(e.target).val();
			if (q) {
				console.log(q);
				window.location.href = '?q=' + q;
			}
		}
	});
	
	var qString = getQueryVariable("q");
	if (qString) {
		$('.input-search').val(decodeURIComponent(qString));
	}
});