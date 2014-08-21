
$.fn.imageview = function(options) {
	var array_imageUrl = [];
	collectAllImageUrl(array_imageUrl, this, options);
	console.log(array_imageUrl);
}

function collectAllImageUrl(array, obj, options) {
	
	var clickDomHandler = function(e) {
		
		var ele = $(e.target);
		var currUrl = ele.attr(options.attrOfUrl);
		var currUrlIdx = array.indexOf(currUrl);
		var arrayLength = array.length;
		
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
			currUrlIdx++;
			if (currUrlIdx > (arrayLength-1)) {
				currUrlIdx = 0;
			}
			var nextUrl = array[currUrlIdx];
			imgObj.attr('src', nextUrl);
			
			adjustImage(imgObj, imgContainer);
			e.stopPropagation();
		});
		
		e.stopPropagation();
	};
	
	var obj = $(obj);
	for (var i=0; i<obj.children().length; i++) {
		var ele = $(obj.children()[i]);
		var imageUrl = ele.attr(options.attrOfUrl);
		if (imageUrl != undefined) {
			array.push(imageUrl);
			ele.css('cursor', 'pointer');
			ele.click(clickDomHandler);
		}
		collectAllImageUrl(array, obj.children()[i], options);
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
	    		$(window).unbind('resize').resize(function(){
	    			imgContainer.height($(window).height());
	    		});
	    	} else {
	    		imgObj.css('height', 'auto');
	    		imgObj.css('width', '100%');
	    	}
	    
	    });
}
