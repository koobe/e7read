/**
 * @author Cloude
 */

(function($) {
	
	function ScrollLoad($this, options) {
		
        this.$this = $this;
        this.options = options;
        
        this.page = 0;
        this.eof = false;
        this.onCall = false;
        
        var tryingLimit = 3;
        var me = this;
        
        $("#" + this.options.scrollingDivId)
	        .scroll(function() {
	        		me.loadmore();
	        })
	        .on({
	            'touchmove': function(e) {
	            		me.loadmore();
	            }
	        });
        
        var initial = function() {
        		if (tryingLimit > 0) {
        			if (($("#" + me.options.scrollingDivId).height() - $("#" + me.options.contentDivId).height()) >= 0) {
	    	        		me.loadmore(initial);
	    	        		tryingLimit--;
	    	        }
        		}
        }
        initial();
    };
    
    ScrollLoad.prototype.loadmore = function(closure) {
    	
    	var me = this;
    	
		if (isLoadMore(me.options) && !me.onCall && !me.eof) {
			
			me.onCall = true;
			
			if (me.options.beforeLoad) {
	    			me.options.beforeLoad();
	    		}
    		
	    		me.page = me.page + 1;
	    		var offset = (me.page * me.options.max) - me.options.max;
	    		console.log('load page: ' + me.page + ', offset: ' + offset);
	    		
	    		var data = $.extend({
	    			max: me.options.max,
	    			offset: offset,
	    		}, me.options.dataParams);		// this will add some query condition from custom parameters
	        
	    		$.ajax({
	    	        type: 'POST',
	    	        data: data,
	    	        url: me.options.dataUrl,
	    	        success: function (data, textStatus) {
    	        		var dataobj = $(data);
    	        		
	    	        	if (data == "") {
	    	        		me.eof = true;
	    	        		console.log('eof');
	    	        	} else {
	    	            $("#" + me.options.contentDivId).append(dataobj);
	    	        	}
	    	        	
	    	        	if (me.options.afterLoad) {
    		    			me.options.afterLoad(dataobj);
    		    		}
	    	        	
	    	        	me.onCall = false;
	    	        	
	    	        	if (closure) {
    	            		closure();
	    	        	}
		    	        	
	    	        },
	    	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	    	        		console.log(textStatus);
	    	        		console.log(errorThrown);
	    	        }
	    		});
		}
		
		function isLoadMore(options) {
			var scrollingDiv = $("#" + options.scrollingDivId);
			var contentDiv = $("#" + options.contentDivId);
			
			var factor = scrollingDiv.scrollTop() + scrollingDiv.height() + 100;
			
			if ((contentDiv.height() - factor) <= 0) {
		        return true;
		    } else {
		    	return false;
		    }
		}
    };
	
	$.contentloading = function(options) {
		
		var options = $.extend({
			max: 6,
			scrollingDivId: null,
			contentDivId: null,
			dataUrl: null,
			dataParams: null,
			beforeLoad: null,
			afterLoad: null
        }, options );
		
		return new ScrollLoad(this, options);
	};
    
}(jQuery));