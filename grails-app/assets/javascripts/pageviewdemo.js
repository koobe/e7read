

$(function() {
	
	var pageId = 0;
	var totalPageNumber = $('.paragraphview').length;
	var pageHash = "#pageheader";
	
	console.log('paragraph count: ' + totalPageNumber);
	
	var onSwipePage = function(e) {
		
		e.preventDefault();
		
		var data;
		if (e.type == 'swipeleft') {
			data = next();
		} else if (e.type == 'swiperight') {
			data = prev();
		}
		
		console.log("navigate to page: " + pageHash);
		$(":mobile-pagecontainer").pagecontainer("change", pageHash, data);
		
		function next() {
			if (pageId < totalPageNumber) {
    			pageId++;
    			pageHash = "#page" + pageId;
    		}
    		
    		return { transition: "flip" }
		}
		
		function prev() {
			if (pageId > 1) {
    			pageId--;
    			pageHash = "#page" + pageId;
    		} else {
    			if (pageId > 0) {
    				pageId--;
	    			pageHash = "#pageheader";
    			}
    		}
        	
    		return { transition: "flip", reverse: true }
		}
	}
	
	$("body").on({
        'swipeleft swiperight': onSwipePage
	});
})
