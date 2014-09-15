/**
 * @author Cloude
 * 
 * depend on:
 * jQuery
 */

(function($) {
	
	function MessageManager($this, options) {
		
		this.$this = $this;
        this.options = options;
        
        this.actionHandlers = {};
        var handlers = this.actionHandlers;
        
        this.$msgListenHandler = function(event) {
        		var data = event.data;
        		console.log('execute message handler: ' + data.action);
        		try {
        			var handler = handlers[data.action];
    	    			handler(data);
        		} catch (err) {
        			console.log('no action handler found: ' + data.action);
        			console.log(err);
        		}
        };
    };
    
    MessageManager.prototype.registerHandler = function(name, handler) {
    		this.actionHandlers[name] = handler;
    };
    
    MessageManager.prototype.sendMessage = function(winobj, message) {
    		winobj.postMessage(message, '*');
    }
    
    MessageManager.prototype.addMessageEvnetListener = function() {
    		window.addEventListener("message", this.$msgListenHandler, false);
    }
	
	$.messagemanager = function( options ) {
		
		var options = $.extend({
        }, options );
		
		var messagemanager = new MessageManager(this, options);
		return messagemanager;
	};
    
}(jQuery));