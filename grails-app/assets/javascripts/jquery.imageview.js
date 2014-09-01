/**
 * @author Cloude
 */

(function($) {
	
	var settings;
	var array = [];
	var arrayLength;
	
	$.fn.imageview = function(options) {
		console.log(options);
		settings = options;
		collectAllImageUrl(this);
		arrayLength = array.length;
		console.log(array + ', length=' + arrayLength);
	}
	
	var clickDomHandler = function(e) {
		var ele = $(e.target);
		var currUrl = ele.attr(settings.attrOfUrl);
		var currUrlIdx = array.indexOf(currUrl);
		
		var imageMaskDiv = $('<div class="imageview-mask-div"></div>');
		var eleContainer = $('<div class="imageview-element-container"></div>');
		var leftBar = $('<div class="imageview-navbar"></div>');
		var imgContainer = $('<div class="imageview-image-container"></div>');
		var rightBar = $('<div class="imageview-navbar"></div>');
		var imgObj = $('<img class="img-thumbnail"></img>');
		
		imgObj.attr('src', currUrl);
		imgObj.css('cursor','pointer');
		
		$('body').append(imageMaskDiv);
		$(imageMaskDiv).append(eleContainer);
		$(eleContainer).append(leftBar).append(imgContainer).append(rightBar);
		$(imgContainer).append(imgObj);
		
		adjustImage(imgObj, imgContainer);
		
		imageMaskDiv.click(function(e){
			imageMaskDiv.remove();
			e.stopPropagation();
		});
		
		imgObj.click(function(e){
			if (arrayLength == 1) {
				imageMaskDiv.remove();
			} else {
				currUrlIdx++;
				if (currUrlIdx > (arrayLength-1)) {
					currUrlIdx = 0;
				}
				var nextUrl = array[currUrlIdx];
				imgObj.attr('src', nextUrl);
				
				adjustImage(imgObj, imgContainer);
			}
			e.stopPropagation();
		});
		e.stopPropagation();
	};
	
	function collectAllImageUrl(obj) {
		var obj = $(obj);
		var imageUrl = obj.attr(settings.attrOfUrl);
		if (imageUrl != undefined) {
			array.push(imageUrl);
			obj.css('cursor', 'pointer');
			obj.click(clickDomHandler);
		}
		for (var i=0; i<obj.children().length; i++) {
			var ele = $(obj.children()[i]);
			collectAllImageUrl(obj.children()[i]);
		}
	}
	
	function adjustImage(imgObj, imgContainer) {
		$('<img/>')
			.attr("src", $(imgObj).attr("src"))
		    .load(function() {
		    	if (this.height > this.width) {
		    		imgContainer.height($(window).height());
		    		imgObj.css('height', '100%');
		    		imgObj.css('width', 'auto');
		    	} else {
		    		imgContainer.height($(window).height());
		    		imgObj.css('height', 'auto');
		    		imgObj.css('max-width', '100%');
		    		imgObj.css('max-height', '100%');
		    	}
		    	$(window).unbind('resize').resize(function(){
	    			imgContainer.height($(window).height());
	    		});
		    });
	}
	
}(jQuery));