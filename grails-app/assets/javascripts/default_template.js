$(function() {
    $('a.content-category').click(function() {
        window.open("/?c="+$(this).data('category-name'), '_top');
    });

    var logo = $("<img src=\"/assets/logo_grey.png\" alt=\"logo\" class=\"e7read-logo\" />");
    logo.click(function() {
        window.open("/", '_top');
    });
    $('body').append(logo);
    
    $('.main-gallery').imageview({
        attrOfUrl: 'data-imageurl'
    });
    
    $('.pictures-container').imageview({
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

});