$(function() {
	$('#display-container')
	    .scroll(function() {
	    	determainDisplay();
	    })
	    .on({
	        'touchmove': function(e) {
	        	determainDisplay();
	        }
	    });
	
	$('.category-status-panel').hide();
})

function determainDisplay() {
	var scrollPos = $('#display-container').scrollTop();
	console.log(scrollPos);
	if (scrollPos < 100) {
		$('.category-status-panel').hide();
	} else {
		console.log('fff');
		$('.category-status-panel').show();
	}
}