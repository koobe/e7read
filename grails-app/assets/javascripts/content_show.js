var backlink = $('<a id="button-back" class="koobe-btn koobe-btn-large back-btn-pos"><i class="fa fa-caret-left"></i></a>');

var is_safari_or_uiwebview = /(iPhone|iPod|iPad).*AppleWebKit/i.test(navigator.userAgent);

// remember the scroll position for iOS
var scrollTop = 0;

// gototop icon button for iOS
var gototop;

var frameDivId = 'open_content_framediv';
var fullframe = $.fullframe({mainDivId: frameDivId, z_index: 400});

var currentContentViewObj;

var channel = getQueryVariable("channel");

var spinner = $.spinner();

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

var viewContentOnTheAirHandler = function(data) {
	
	spinner.loading();
	
	console.log('Open content: ' + data.contentId);
	backlink.click(function() {
        history.back();
    });
    $('body').append(backlink);
    
    gototop = $('body').gototop({
    	containerSelector: 'body',
		z_index: 9999,
		auto_hide: false
	});
    
    
    $('#display-container').css('display', 'none');
	scrollTop = $(window).scrollTop();
    
    $.ajax({
        type: 'GET',
        data: {id: data.contentId, channel: channel},
        url: '/content/getContentViewHTML',
        success: function (data, textStatus) {
    		var dataobj = $(data);
    		currentContentViewObj = dataobj;
    		
        	if (data == "") {
        		console.log('No content view html can show');
        	} else {
        		
        		addHandlers(dataobj);
        		
        		$('body').append(dataobj);
        		$('body').css('overflow', 'auto');
        		
        		FB.XFBML.parse(document.getElementById('fb-comments'));
        		
        		spinner.done();
        	}
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        		console.log(textStatus);
        		console.log(errorThrown);
        }
	});
    
    
};

var closeIframeHandler = function() {
//	if (is_safari_or_uiwebview) {
		$('#display-container').css('display', '');
		$(window).scrollTop(scrollTop);
//		try {gototop.remove();} catch (err) {console.log(err);}
//	}
		
	if (gototop) {
		gototop.remove();
	}
	
	backlink.remove();
	
	if (currentContentViewObj) {
		currentContentViewObj.remove();
		currentContentViewObj = null;
	}
	
	fullframe.closeFrame();
};

var hashmanager = $.hashmanager();
hashmanager.registerHandler('viewContent', viewContentHandler);
hashmanager.registerHandler('viewContentOnTheAir', viewContentOnTheAirHandler);
hashmanager.registerHandler('hashmanager_defaulthandler', closeIframeHandler);

$(function() {
    // Use container scrollbar instead of full page scrollbar
    $('body').css('height', '100%'); //.css('overflow', 'hidden');
    $('#display-container').css('height', '100%').css('overflow-y', 'scroll').css('-webkit-overflow-scrolling', 'touch');
});

/**
 * 
 * @param contentId
 */
function showContent(contentId) {
	
//	if (is_safari_or_uiwebview) {
//		window.open('/share/' + contentId, '_blank'); 
//	} else {
//		var data = {};
//		data.action = 'viewContent';
//		data.contentId = contentId;
//		hashmanager.push(data);
//	}
	
	var data = {};
	data.action = 'viewContentOnTheAir';
	data.contentId = contentId;
	hashmanager.push(data);
}



function addHandlers(contentViewObject) {
	
	
	
//	$('body').e7readcstatuspanel({});
    
    $('.main-gallery, .pictures-container, .imagetitle-container, .image-gallery', contentViewObject).imageview({
        attrOfUrl: 'data-imageurl'
    });
	
	$('.text-container p', contentViewObject).linkify();
	
	$('.author-click', contentViewObject).click(function() {
    	window.open("/" + channel + "?u="+$(this).data('user-id'), '_top');
    });

    $('.content-category-name', contentViewObject).css('cursor', 'pointer').click(function() {
    	window.open("/" + channel + "?c="+$(this).data('categoryname'), '_top');
    });
    
    
    $('.text-container a', contentViewObject).each(function() {
    	
    	console.log('process link');

        var getUrlParameter = function(sUrl, sParam) {
            var url = sUrl.split('?')[1];
            var sURLVariables = url.split('&');
            for (var i = 0; i < sURLVariables.length; i++) {
                var sParameterName = sURLVariables[i].split('=');
                if (sParameterName[0] == sParam) {
                    return sParameterName[1];
                }
            }
        };
        var href = $(this).attr('href');
        var matches = href.match(/^http:\/\/(?:www\.)?youtube.com\/watch\?(?=.*v=\w+)(?:\S+)?$/);
        if (matches) {
            var youtubeId = getUrlParameter(href, 'v');

            var div = $('<div class="embed-responsive embed-responsive-16by9"></div>');
            var iframe = $('<iframe type="text/html"></iframe>');
            iframe.attr('src', 'http://www.youtube.com/embed/'+youtubeId);
            iframe.addClass('embed-responsive-item');
            
            div.append(iframe);
            $(div).insertBefore(this);
        }
        
        var matchsImg = href.toLowerCase().match(/.(jpg|jpeg|png|gif)$/);
        if (matchsImg) {
    		var img = $('<img/>');
    		img.css('max-width','100%');
    		img.attr('src', href);
    		$(img).insertBefore(this);
    		$('<br/>').insertBefore(this);
    		this.remove();
        }
    });
}
