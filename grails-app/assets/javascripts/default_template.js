$(function() {
    
    $('body').e7readcstatuspanel({});
    
    $('.main-gallery, .pictures-container').imageview({
        attrOfUrl: 'data-imageurl'
    });
    
    var is_safari_or_uiwebview = /(iPhone|iPod|iPad).*AppleWebKit/i.test(navigator.userAgent);
    if (!is_safari_or_uiwebview) {
    	$('body').gototop({
    		containerId: 'content-body',
    		z_index: 300,
    		auto_hide: false
    	});
    }
    
    $('.author-click').click(function() {
    	window.open("/?u="+$(this).data('user-id'), '_top');
    });

    $('.content-category-name').css('cursor', 'pointer').click(function() {
    	 window.open("/?c="+$(this).data('categoryname'), '_top');
    });

    $('p').linkify();

    $('.text-container a').each(function() {

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
//            iframe.width(640).height(390).attr('frameborder', 0);
            iframe.attr('src', 'http://www.youtube.com/embed/'+youtubeId);
            iframe.addClass('embed-responsive-item');
            
            div.append(iframe);
            $(div).insertBefore(this);
//            $('<br/>').insertAfter(div);
        }
        
        var matchsImg = href.toLowerCase().match(/.(jpg|jpeg|png|gif)$/);
        if (matchsImg) {
        		var img = $('<img/>');
        		img.css('max-width','100%');
        		img.attr('src', href);
        		$(img).insertBefore(this);
        		$('<br/>').insertBefore(this);
        }
    });
});