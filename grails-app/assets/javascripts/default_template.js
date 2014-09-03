$(function() {
    $('a.content-category').click(function() {
        window.open("/?c="+$(this).data('category-name'), '_top');
    });

    
    
    var logodiv = $('<div/>').addClass('e7read-logo-div');
    var logodivcell = $('<div/>').addClass('e7read-logo-cell');
    var logoimg = $('<img src="/assets/trans_logo.png" alt="logo" class="e7read-logo" />');
    logoimg.click(function() {
        window.open("/", '_top');
    });
    $('body').append(logodiv.append(logodivcell.append(logoimg)));
    
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