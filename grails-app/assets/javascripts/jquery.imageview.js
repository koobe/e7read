/**
 * @author Cloude
 */

(function($) {
	
	function ImageView($this, options, array) {
        this.$this = $this;
        this.options = options;
        this.$array = array;
        
        var imageMaskDiv = $('<div class="imageview-mask-div"></div>');
		var eleContainer = $('<div class="imageview-element-container"></div>');
		var leftBar = $('<div class="imageview-navbar"></div>');
		var imgContainer = $('<div class="imageview-image-container"></div>');
		var rightBar = $('<div class="imageview-navbar"></div>');
		var imgObj = $('<img class="img-thumbnail" alt="thumbnail" />');
		imgObj.css('cursor','pointer');
		
		$(imageMaskDiv).append(
				eleContainer
					.append(leftBar)
					.append(imgContainer
							.append(imgObj))
					.append(rightBar));
		
		this.$maskDiv = imageMaskDiv;
		this.$imgDiv = imgContainer;
		this.$img = imgObj;
    };
    
    ImageView.prototype.openView = function(imageUrl) {
    	this.$img.attr('src', imageUrl);
    	$('body').append(this.$maskDiv);
    	
    	var array = this.$array;
    	var currUrlIdx = array.indexOf(imageUrl);
    	
    	var imageMaskDiv = this.$maskDiv;
    	imageMaskDiv.click(function(e){
			imageMaskDiv.remove();
			e.stopPropagation();
		});
    	
    	var imgContainer = this.$imgDiv;
    	var imgObj = this.$img;
		imgObj.click(function(e){
			if (array.length == 1) {
				imageMaskDiv.remove();
			} else {
				currUrlIdx++;
				if (currUrlIdx > (array.length-1)) {
					currUrlIdx = 0;
				}
				var nextUrl = array[currUrlIdx];
				imgObj.attr('src', nextUrl);
				
				adjustImage(imgObj, imgContainer);
			}
			e.stopPropagation();
		});
    	
    	adjustImage(this.$img, this.$imgDiv);
    	
    	function adjustImage(imgObj, imgContainer) {
    		$('<img/>')
    			.attr("src", $(imgObj).attr("src"))
    		    .load(function() {
    		    	if (this.height > this.width) {
    		    		imgObj.css('width', 'auto');
    		    		imgObj.css('max-width', '100%');
    		    		imgObj.css('max-height', '100%');
    		    	} else {
    		    		imgObj.css('height', 'auto');
    		    		imgObj.css('max-width', '100%');
    		    		imgObj.css('max-height', '100%');
    		    	}
    		    	imgContainer.height($(window).height());
    		    	$(window).unbind('resize').resize(function(){
    	    			imgContainer.height($(window).height());
    	    		});
    		    });
    	}
    };
	
	$.fn.imageview = function(options) {
				
		var settings = $.extend({
			showInParent: true
        }, options );
		
		var array = [];
		
		var imageviewobj = new ImageView(this, settings, array);
		
		collectAllImageUrl(this, array, settings, imageviewobj);
		
		function collectAllImageUrl(obj, array, settings, imageviewobj) {
			var obj = $(obj);
			var imageUrl = obj.attr(settings.attrOfUrl);
			if (imageUrl != undefined) {
				array.push(imageUrl);
				obj.css('cursor', 'pointer');
				obj.click(function(e) {
					var obj = e.target;
					clickImageHandler(obj, array, settings, imageviewobj);
					e.stopPropagation();
				});
			}
			for (var i=0; i<obj.children().length; i++) {
				var ele = $(obj.children()[i]);
				collectAllImageUrl(obj.children()[i], array, settings, imageviewobj);
			}
		}
		
		function clickImageHandler(obj, array, settings, imageviewobj) {
			obj = $(obj);
			var currUrl = obj.attr(settings.attrOfUrl);
			var currUrlIdx = array.indexOf(currUrl);
			
			if (settings.showInParent) {
				var parent = window.parent;
				if (window != parent) {
					var data = {
						imageUrl: currUrl,
						imageArray: array
					};
					parent.postMessage(data, '*');
				} else {
					console.log('no parent window found!');
					imageviewobj.openView(currUrl);
				}
			} else {
				imageviewobj.openView(currUrl);
			}
		};
		
		return imageviewobj;
	};
	
	$.imageview = function( options ) {
		
		var settings = $.extend({
        }, options );
		
		var array = settings.imageArray;
		
		return new ImageView(this, settings, array);
	};
	
}(jQuery));