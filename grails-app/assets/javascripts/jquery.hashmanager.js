/**
 * @author Cloude
 * 
 * depend on:
 * jQuery
 */

(function($) {
	
	function HashManager($this, options) {
		
		this.$this = $this;
        this.options = options;
        
        this.actionHandlers = {};
        var handlers = this.actionHandlers;
        
        var onhashchange = function() {
        		try {
	        		if (window.location.hash && window.location.hash.length > 0) {
	        			var hashobj = JSON.parse(b64_to_utf8(window.location.hash.substring(1)));
	            		var handler = handlers[hashobj.action];
	            		handler(hashobj);
	        		} else if (window.location.hash == '') {
	        			var handler = handlers['hashmanager_defaulthandler'];
	        			if (handler) {
	        				handler();
	        			}
	        		}
        		} catch (err) {
        			console.log(err);
        			var handler = handlers['hashmanager_defaulthandler'];
        			if (handler) {
        				handler();
        			}
        		}
        };
        this.$onhashchange = onhashchange;
        
        if ("onhashchange" in window) {
        	
        		window.onhashchange = onhashchange;
        } else {
        		var message = "The browser doesn't support the hashchange event!";
        		console.log(message);
        		alert(message);
        }
    };
    
    HashManager.prototype.push = function (data) {
    		var value = utf8_to_b64(JSON.stringify(data));
    		window.location.hash = value;
    };
    
    HashManager.prototype.registerHandler = function(name, handler) {
    		this.actionHandlers[name] = handler;
    		console.log(this.actionHandlers);
    };
	
	$.hashmanager = function( options ) {
		
		var options = $.extend({
			
        }, options );
		
		var hashmanager = new HashManager(this, options);
		
		// run registered action when window loaded
		$(function() {
			hashmanager.$onhashchange();
		});
		
		return hashmanager;
	};
	
	function utf8_to_b64( str ) {
	    return window.btoa(encodeURIComponent( escape( str )));
	}

	function b64_to_utf8( str ) {
	    return unescape(decodeURIComponent(window.atob( str )));
	}
    
}(jQuery));