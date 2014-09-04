$(function() {
		
    $('a.content-category').click(function() {
        window.open("/?c="+$(this).data('category-name'), '_top');
    });
    
    $('body').e7readcstatuspanel({});
    
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