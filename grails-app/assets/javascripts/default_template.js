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
    
});