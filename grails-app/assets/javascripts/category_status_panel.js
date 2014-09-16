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
	if (scrollPos < 100) {
		$('.category-status-panel').hide();
	} else {
		$('.category-status-panel').show();
	}
}