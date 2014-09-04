/**
 * @author Cloude
 * 
 * depend on:
 * jquery: http://jquery.com/
 */

(function($) {
		
	$.fn.e7readcstatuspanel = function(options) {
		
		var settings = $.extend({
			isShowNowAt: false,
			position: 'absolute'
        }, options );
		
		var divcatestatusindicator = $('<div/>').addClass('category-status-panel');
		divcatestatusindicator.css('position', 'absolute');
		
	    var logodivcell = $('<div/>').addClass('table-cell');
	    var logoimg = $('<img src="/assets/trans_logo.png" alt="logo" class="e7read-logo" />');
	    logoimg.click(function(e) {
	    	window.open("/", '_top');
	    	e.stopPropagation();
	    });
	    
	    var cellstatusindicator;
	    var nowAt;
	    
	    if (settings.isShowNowAt) {
	    	cellstatusindicator = $('<div/>').addClass('table-cell').addClass('category-status-indicator');
	    	var spannowat = $('<span/>');
	    	var spancatename = $('<span/>').addClass('category-status-name-text');;
	    	spannowat.text('Now at: ');
	    	nowAt = getQueryVariable('c');
	    	spancatename.text(nowAt);
	    	cellstatusindicator.append(spannowat).append(spancatename);
	    }
	    
	    var cellopensidemenu = $('<div class="table-cell"><img src="/assets/grey_arrow.png" class="category-status-catebtn"></div>');
		
	    if (settings.isShowNowAt && nowAt) {
	    	divcatestatusindicator.append(logodivcell.append(logoimg)).append(cellstatusindicator).append(cellopensidemenu);
	    } else {
	    	divcatestatusindicator.append(logodivcell.append(logoimg)).append(cellopensidemenu);
	    }
		
		$(this).append(divcatestatusindicator);
		
		var me = $(this);
		
		$.ajax({
			type:'POST',
			data: {btnaction: 'home'},
			url:'/category/addCategoryPanel',
			success:function(data,textStatus){
				var sidemenu = $(data);
				me.append(sidemenu);
				
				cellopensidemenu.click(function(e) {
					sidemenu.show(300);
					e.stopPropagation();
				});
				
				sidemenu.find('.back-button').click(function(e) {
					sidemenu.hide(200);
					e.stopPropagation();
				});
				
				sidemenu.find('.gotocategorylink*').removeAttr('href').css('cursor', 'pointer').click(function(e) {
					window.open("/?c="+$(this).data('category-name'), '_top');
					e.stopPropagation();
				});
			},
			error:function(XMLHttpRequest,textStatus,errorThrown){}
		});
	};
	
	function getQueryVariable(variable) {
       var query = window.location.search.substring(1);
       var vars = query.split("&");
       for (var i=0;i<vars.length;i++) {
               var pair = vars[i].split("=");
               if(pair[0] == variable){return pair[1];}
       }
       return(false);
	}
    
}(jQuery));