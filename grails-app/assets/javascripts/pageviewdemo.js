var pageId = 1;
var totalPageNumber = 13;

$(function() {
	$("body").on({
        'swipeleft': function(e) {
        		e.preventDefault();
	        	if (pageId < totalPageNumber) {
	    			pageId++;
	    		}
	    		console.log("navigate to pageId: " + pageId);
//	    		$.mobile.navigate( "#pageid-" + pageId );
	    		$( ":mobile-pagecontainer" ).pagecontainer( "change", "#pageid-" + pageId, {
	    			transition: "flip"
	    		} );
	    }
	});
	
	$("body").on({
        'swiperight': function(e) {
        		e.preventDefault();
	        	if (pageId > 1) {
	    			pageId--;
	    		}
	    		console.log("navigate to pageId: " + pageId);
//	    		$.mobile.navigate( "#pageid-" + pageId );
	    		$( ":mobile-pagecontainer" ).pagecontainer( "change", "#pageid-" + pageId, {
	    			transition: "flip",
	    			reverse: true
	    		} );
	    }
	});
})

//$(document).on( "pagecreate", ".paragraphview", function() {
//	
//	$(document).on( "swipeleft",  "body", function(event) {
//		if (pageId < totalPageNumber) {
//			pageId++;
//		}
//		console.log("navigate to pageId: " + pageId);
////		$.mobile.navigate( "#pageid-" + pageId );
////		event.preventDefault();
//		
////		$( ":mobile-pagecontainer" ).pagecontainer( "change", "#", {
////            transition: "slide"
////        });
//	});
//	
//	$(document).on( "swiperight",  "body", function(event) {
//		if (pageId > 1) {
//			pageId--;
//		}
//		console.log("navigate to pageId: " + pageId);
//		$.mobile.navigate( "#pageid-" + pageId );
//		event.preventDefault();
//	});
//	
//});