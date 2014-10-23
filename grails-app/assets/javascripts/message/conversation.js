$(function() {
	
	var s = $.spinner({bottom: '80px', fadeTime: 400});
	var isLoading = false;
	
	var mbId = getQueryVariable("messageBoardId");
	var max = getQueryVariable("max");
	var totalSize = getQueryVariable("totalSize");
	var currPage = 0;
	var lastTime;
	
	retriveData();
	
	fitContentHeight();
	
	var loadPreviousBtnClickHandler = function(e) {
		if (!isLoading) {
			
			$('.message-content-btn-loadmore').css('display', 'none');
			retriveData();
		}
	};
	
	$('.message-content-btn-loadmore > button').click(loadPreviousBtnClickHandler);
	
	$(window).unbind('resize').resize(function(){
		fitContentHeight();
	});
	
	function fitContentHeight() {
		var messageContentHeight = $('body').height() - $('nav').height() - $('footer').height();
		$('.message-content-container').height(messageContentHeight);
	}
	
	function scrollToBottom() {
		$('.message-content-container').scrollTop($('.message-content').height());
	}
	
	function retriveData() {
		
		isLoading = true;
		s.loading();
		
		currPage++;
		
		var offset = (currPage * max) - max;
		
		var data = {
			id: mbId,
			max: max,
			offset: offset
		};
		
		if (lastTime) {
			data = $.extend({
				lastTime: lastTime
	        }, data );
		}
		
		$.ajax({
	        type: 'GET',
	        data: data,
	        url: '/message/getMessageData',
	        success: function (data, textStatus) {
	        	console.log(data);
	        	renderHtml(data);
	        	controlShowMoreButton();
	        	s.done();
	        	isLoading = false;
	        	
	        	if (currPage == 1) {
	    			scrollToBottom();
	    		}
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	    		console.log(textStatus);
	    		console.log(errorThrown);
	        }
		});
	}
	
	function renderHtml(data) {
		
		if (!lastTime) {
			lastTime = data.lastTime;
		}
		
		var results = data.results;
		
		results.forEach(function(element, index, array) {
			
			var message = element.message;
			var side = element.side;
			var sender = element.sender;
			
			var divMsgEntry = $('<div/>').addClass(side);
			var divMsgBubble = $('<div/>').addClass('bubble');
			
			var divUser = $('<div class="message-author" />')
				.append($('<i class="fa fa-user"></i>'))
				.append("&nbsp;")
				.append($('<span>' + sender + '</span>'));
			
			var divMsg = $('<div/>').append($('<span>' + message + '</span>'));
			
			divMsgEntry.append(divMsgBubble.append(divUser).append(divMsg));
			
			$('.message-content-anchor').after(divMsgEntry);
		});
	}
	
	function controlShowMoreButton() {
		if ((currPage * max) >= totalSize) {
			$('.message-content-btn-loadmore').css('display', 'none');
		} else {
			$('.message-content-btn-loadmore').css('display', 'block');
		}
	}
	
	function postMessage() {
		
	}
});

