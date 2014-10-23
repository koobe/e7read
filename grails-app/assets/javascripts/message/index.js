$(function() {
	
	var isFetch = false;
	
	var totalSize = getQueryVariable("totalSize");
	var pageSize = getQueryVariable("max");
	
	var currPage = 1;
	var totalPages = Math.ceil(totalSize / pageSize);
	
	console.log('total size: ' + totalSize + ', page size: ' + pageSize + ', total pages: ' + totalPages);
	
	$('.pager .previous').click(function(e) {
		newer();
	});
	
	$('.pager .next').click(function(e) {
		older();
	});
	
	determineButtonAction();
	fetchData();
	
	function older() {
		if (!isFetch) {
			if (currPage < totalPages) {
				currPage = currPage + 1;
				determineButtonAction();
				fetchData();
			}
		}
	}
	
	function newer() {
		if (!isFetch) {
			if (currPage > 1) {
				currPage = currPage - 1;
				determineButtonAction();
				fetchData();
			}
		}
	}
	
	function determineButtonAction() {
		console.log('current page: ' + currPage);
		
		$('.pager .previous').removeClass('disabled');
		$('.pager .next').removeClass('disabled');
		
		if (currPage <= 1) {
			$('.pager .previous').addClass('disabled');
		}
		if (currPage >= totalPages) {
			$('.pager .next').addClass('disabled');
		}
	}
	
	function fetchData() {
		
		isFetch = true;
		var offset = (currPage * pageSize) - pageSize;
		
		$.ajax({
	        type: 'POST',
	        data: {max: pageSize, offset: offset},
	        url: '/message/renderMessageBoardTable',
	        success: function (data, textStatus) {
	        	$('#messageboard-table').html(data);
	        	isFetch = false;
	        	
	        	var dataobj = $(data);
	        	$('.open-conversation', dataobj).click(function() {
	        		window.open('/message/conversation/' + $(this).data('messageBoardId'), '_blank'); 
	        	});
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	    		console.log(textStatus);
	    		console.log(errorThrown);
	        }
		});
		
	}
	
});

