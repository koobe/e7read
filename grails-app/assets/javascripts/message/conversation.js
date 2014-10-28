$(function() {
	
	var s = $.spinner({bottom: '80px', fadeTime: 10});
	var isLoadingPrev = false;
	var isLoadingNewer = false;
	
	var mbId = getQueryVariable("messageBoardId");
	var max = getQueryVariable("max");
	var totalSize = getQueryVariable("totalSize");
	var currPage = 0;
	var lastPrevMsgTime;
	var firstNewerMsgTime;
	
	var minWaitTimeout = 6500;
	var maxWaitTimeout = 30000;
	var currTimeout = 15000;
	var hasNewMessage = false;
	
	fitContentHeight();
	retrievePreviousMessage();
	
//	var timeoutFunc = function() {
//		console.log('Set retrieve new message timeout: ' + currTimeout);
//		setTimeout(function() {
//			retrieveNewerMessage(function() {
//				
//				if (hasNewMessage) {
//					currTimeout = Math.ceil(currTimeout / 2.5);
//					if (currTimeout < minWaitTimeout) {
//						currTimeout = minWaitTimeout;
//					}
//				} else {
//					currTimeout = Math.ceil(currTimeout * 1.5);
//					if (currTimeout > maxWaitTimeout) {
//						currTimeout = maxWaitTimeout;
//					}
//				}
//				
//				timeoutFunc();
//			});
//		}, currTimeout);
//	};
//	
//	timeoutFunc();
	
	setInterval(function(){retrieveNewerMessage();}, 10000);
	
	var loadMoreMessageHandler = function(e) {
		if (!isLoadingPrev) {
			
			$('.message-content-btn-loadmore').css('display', 'none');
			retrievePreviousMessage();
		}
	};
	
	var sendMessageHandler = function(e) {
		if (e.type == 'click') {
			sendMessage();
		} else if (e.type == 'keydown') {
			if (e.keyCode == 13) {
				sendMessage();
				e.preventDefault();
			}
		}
	};
	
	$('.message-content-btn-loadmore > button').click(loadMoreMessageHandler);
	$('.send-messagebox button').click(sendMessageHandler);
	$('.send-messagebox textarea').keydown(sendMessageHandler);
	
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
	
	function retrievePreviousMessage() {
		
		isLoadingPrev = true;
		s.loading();
		
		currPage++;
		
		var offset = (currPage * max) - max;
		
		var data = {
			mbId: mbId,
			max: max,
			offset: offset
		};
		
		if (lastPrevMsgTime) {
			data = $.extend({
				lastPrevMsgTime: lastPrevMsgTime
	        }, data );
		}
		
		sendAjaxRequest('GET', data, '/message/getMessageData', function(data, textStatus) {
			renderPreviousMessageHtml(data);
        	controlShowMoreButton();
        	s.done();
        	isLoadingPrev = false;
        	
        	if (currPage == 1) {
    			scrollToBottom();
    		}
		});
	}
	
	function retrieveNewerMessage(handler) {
		
		if (!isLoadingNewer) {
			
			isLoadingNewer = true;
			
			var data = {
				mbId: mbId,
				lastPrevMsgTime: lastPrevMsgTime,
				newer: true
			};
			
			if (firstNewerMsgTime) {
				data = $.extend({
					firstNewerMsgTime: firstNewerMsgTime
		        }, data );
			}
			
			sendAjaxRequest('GET', data, '/message/getMessageData', function(data, textStatus) {
				
				var factor = $('.message-content-container').scrollTop() + $('.message-content-container').height();
				
				var isScrollToBottom = false;
				if (factor >= ($('.message-content').height() - 50)) {
					isScrollToBottom = true;
				}
				
				renderNewerMessageHtml(data);
				
				if (handler) {
					handler();
				}
				
				if (isScrollToBottom) {
					scrollToBottom();
				}
				
				isLoadingNewer = false;
			});
		}
		
	}
	
	function renderPreviousMessageHtml(data) {
		
		if (!lastPrevMsgTime) {
			lastPrevMsgTime = data.lastPrevMsgTime;
		}
		
		var results = data.results;
		
		results.forEach(function(element, index, array) {
			
			var msgBubble = getMessageBubble(element);
			
			$('.message-content-anchor').after(msgBubble);
		});
	}
	
	function renderNewerMessageHtml(data) {
		
		if (data.firstNewerMsgTime) {
			firstNewerMsgTime = data.firstNewerMsgTime
		}
		
		var results = data.results;
		
		results.forEach(function(element, index, array) {
			
			var msgBubble = getMessageBubble(element);
			
//			$('.message-content-anchor-last').after(messageBubble);
			$('.message-content').append(msgBubble);
		});
		
		if (results.length == 0) {
			hasNewMessage = false;
		} else {
			hasNewMessage = true;
		}
	}
	
	function controlShowMoreButton() {
		if ((currPage * max) >= totalSize) {
			$('.message-content-btn-loadmore').css('display', 'none');
		} else {
			$('.message-content-btn-loadmore').css('display', 'block');
		}
	}
	
	function sendMessage() {
		
		var message = $('#messagebox-textarea').val().trim();
		
		if (!(message == '')) {
			
			s.loading('Sending...');
			
			var data = {
				mbId: mbId,
				message: message
			};
			
			sendAjaxRequest('POST', data, '/message/postMessageData', function(data, textStatus) {

				$('#messagebox-textarea').val('');
				
				var handler = function() {
					scrollToBottom();
					s.done();
				};
				
				retrieveNewerMessage(handler);
			});
		}
	}
	
	function sendAjaxRequest(type, data, url, callbackSuccess) {
		$.ajax({
	        type: type,
	        data: data,
	        url: url,
	        success: callbackSuccess,
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	    		console.log(textStatus);
	    		console.log(errorThrown);
	        }
		});
	}
	
	function getMessageBubble(message) {
		
		var msg = message.message;
		var side = message.side;
		var sender = message.sender;
		var sendTime = message.sendTime;
		
		var divMsgEntry = $('<div/>').addClass(side);
		var divMsgBubble = $('<div/>').addClass('bubble');
		
		var divUser = $('<div class="message-author"/>')
			.append($('<i class="fa fa-user"/>'))
			.append("&nbsp;")
			.append($('<span/>').html(sender));
		
		var divMsg = $('<div/>').append($('<span/>').html(msg));
		var divSendTime = $('<div class="message-sendtime"/>').append($('<span/>').html(sendTime));
		
		divMsgEntry.append(divMsgBubble.append(divUser).append(divMsg));
		divMsgEntry.append(divSendTime);
		
		return divMsgEntry;
	}
});

