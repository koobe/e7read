var onshowiframe = false;
var scrollTop;

var hashChanged = function(hash) {
    console.log('hashChanged: ' + hash);
    if (hash && hash.indexOf('#content-') >= 0) {
        showContentImpl(hash.replace('#content-', ''));
    }
    else {
        closeIframe();
    }
};

//window.onpopstate = function(event) {
//    alert("location: " + document.location + ", state: " + JSON.stringify(event.state));
//};

var anchorChangeHandler = function() {

    if ("onhashchange" in window) { // event supported?
        window.onhashchange = function () {
            hashChanged(window.location.hash);
        };
    }
    else { // event not supported:
        var storedHash = window.location.hash;
        window.setInterval(function () {
            if (window.location.hash != storedHash) {
                storedHash = window.location.hash;
                hashChanged(storedHash);
            }
        }, 100);
    }
};

$(function() {
    // Use container scrollbar instead of full page scrollbar
    $('body').css('height', '100%').css('overflow', 'hidden');
    $('#display-container').css('height', '100%').css('overflow-y', 'scroll').css('-webkit-overflow-scrolling', 'touch');

    window.addEventListener("message", receiveMessage, false);

    if ('onpopstate' in window) {
        console.log("onpopstate in window");
//        window.onpopstate = function(event) {
//            console.log('onpopstate');
//            //closeIframe();
//        };
    }
    else {
        console.log("onpopstate not in window");
    }

    anchorChangeHandler();

    if (window.location.hash.indexOf('#content-') >= 0) {
        showContentImpl(window.location.hash.replace('#content-', ''));
    }
});

function receiveMessage(event) {
	console.log('Receive message: ' + event.data);
}

//border: 1px solid #94E6DA;
var responsiveiframe = '<div id="div-iframe" class="div-iframe embed-responsive" style="border:none;height:100%; width:100%; position:fixed;top:0px;left:0px; overflow:auto;-webkit-overflow-scrolling:touch;"><iframe class="iframe embed-responsive-item" src=""></iframe></div>';
//var iframe = '<iframe id="iframe-show-content" frameborder="0" style="display:none;overflow:hidden;overflow-x:hidden;overflow-y:hidden;height:100%;width:100%;position:fixed;top:0px;left:0px;right:0px;bottom:0px;z-index:999;" height="100%" width="100%"></iframe>';
//var backmenu = '<div class="contentback"><div><span class="fa fa-caret-left"></span></div></div>';
var backlink = '<a id="button-back" class="koobe-btn koobe-btn-large back-btn-pos"><i class="fa fa-caret-left"></i></a>'

function showContent(contentId) {
    window.location.hash = 'content-' + contentId;
}

var gototop;

function showContentImpl(contentId) {

    if (!contentId) {
        return;
    }

	console.log('Open content: ' + contentId);
	
	onshowiframe = true;

	var is_safari_or_uiwebview = /(iPhone|iPod|iPad).*AppleWebKit/i.test(navigator.userAgent);
	if (is_safari_or_uiwebview) {
		$('#display-container').css('display', 'none');
		scrollTop = $(window).scrollTop();
	}

    var iframe = $(responsiveiframe);
    iframe.find('.iframe').attr('src', '/content/embed/' + contentId);

    var back = $(backlink);
    back.click(function() {
        //closeIframe();
        history.back();
    });

	$('body')
        .append(iframe)
	    //.css('overflow', 'hidden')
	    .append(back);

	if (is_safari_or_uiwebview) {
		gototop = $('body').gototop({
			containerId: 'div-iframe',
			z_index: 9999,
			auto_hide: false
		});
		
//		gototop.remove();
	}
	//history.pushState("", contentId, window.location.pathname + "#content-" + contentId);
}

function closeIframe() {
	var is_safari_or_uiwebview = /(iPhone|iPod|iPad).*AppleWebKit/i.test(navigator.userAgent);
	if (is_safari_or_uiwebview) {
		$('#display-container').css('display', '');
		$(window).scrollTop(scrollTop);
	}
	
	$('#button-back').remove();
	$('.div-iframe').remove();
	//$('body').css('overflow', '');
	gototop.remove();
	
	onshowiframe = false;
}
