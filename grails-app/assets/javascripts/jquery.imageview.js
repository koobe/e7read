/**
 * @author Cloude
 */

(function($) {
	
	$.fn.imageview = function(options) {
		var settings = options;
		var array = [];
		collectAllImageUrl(this, array, settings);
//		console.log(array);
	}
	
	function collectAllImageUrl(obj, array, settings) {
		var obj = $(obj);
		var imageUrl = obj.attr(settings.attrOfUrl);
		if (imageUrl != undefined) {
			array.push(imageUrl);
			obj.css('cursor', 'pointer');
			obj.click(function(e) {
				var obj = (e.target);
				clickImageHandler(obj, array, settings);
				e.stopPropagation();
			});
		}
		for (var i=0; i<obj.children().length; i++) {
			var ele = $(obj.children()[i]);
			collectAllImageUrl(obj.children()[i], array, settings);
		}
	}
	
	function clickImageHandler(obj, array, settings) {
		
		obj = $(obj);
		var currUrl = obj.attr(settings.attrOfUrl);
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
		
	};
	
	function adjustImage(imgObj, imgContainer) {
		$('<img/>')
			.attr("src", $(imgObj).attr("src"))
		    .load(function() {
		    	if (this.height > this.width) {
//		    		imgObj.css('height', '100%');
		    		imgObj.css('width', 'auto');
		    		imgObj.css('max-width', '100%');
		    		imgObj.css('max-height', '100%');
		    	} else {
		    		imgObj.css('height', 'auto');
		    		imgObj.css('max-width', '100%');
		    		imgObj.css('max-height', '100%');
		    	}
//		    	alert($(window).height() + ", " + window.screen.availHeight);
//		    	imgContainer.height(window.screen.availHeight);
		    	imgContainer.height($(window).height());
		    	$(window).unbind('resize').resize(function(){
//	    			imgContainer.height(window.screen.availHeight);
	    			imgContainer.height($(window).height());
	    		});
		    });
	}
	
}(jQuery));