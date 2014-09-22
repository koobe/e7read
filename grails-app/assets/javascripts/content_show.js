var backlink = $('<a id="button-back" class="koobe-btn koobe-btn-large back-btn-pos"><i class="fa fa-caret-left"></i></a>');

var is_safari_or_uiwebview = /(iPhone|iPod|iPad).*AppleWebKit/i.test(navigator.userAgent);

// remember the scroll position for iOS
var scrollTop = 0;

// gototop icon button for iOS
var gototop;

var frameDivId = 'open_content_framediv';
var fullframe = $.fullframe({mainDivId: frameDivId, z_index: 400});

var viewContentHandler = function(data) {
	
	if (data.contentId) {
		console.log('Open content: ' + data.contentId);
		backlink.click(function() {
	        history.back();
	    });
	    $('body').append(backlink);
	    
	    fullframe.openFrame('/content/embed/' + data.contentId);
	    
	    if (is_safari_or_uiwebview) {
	    		$('#display-container').css('display', 'none');
			scrollTop = $(window).scrollTop();
			
			gototop = $('body').gototop({
				containerId: frameDivId,
				z_index: 9999,
				auto_hide: false
			});
		}
	}
}

var closeIframeHandler = function() {
	if (is_safari_or_uiwebview) {
		$('#display-container').css('display', '');
		$(window).scrollTop(scrollTop);
		try {gototop.remove();} catch (err) {console.log(err);}
	}
	backlink.remove();
	fullframe.closeFrame();
};

var hashmanager = $.hashmanager();
hashmanager.registerHandler('viewContent', viewContentHandler);
hashmanager.registerHandler('hashmanager_defaulthandler', closeIframeHandler);

$(function() {
    // Use container scrollbar instead of full page scrollbar
    $('body').css('height', '100%').css('overflow', 'hidden');
    $('#display-container').css('height', '100%').css('overflow-y', 'scroll').css('-webkit-overflow-scrolling', 'touch');
});

/**
 * 
 * @param contentId
 */
function showContent(contentId) {
	if (is_safari_or_uiwebview) {
		window.open('/share/' + contentId, '_blank'); 
	} else {
		var data = {};
		data.action = 'viewContent';
		data.contentId = contentId;
		hashmanager.push(data);
	}
}