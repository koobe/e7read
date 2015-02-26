$(function() {
	
	$('.page-range-selector-btn-cancel').click(function() {
		$('.page-range-selector').hide();
	});
	
	$('.page-range-selector-btn-confirm').click(function() {
		var startPageId = $('#startPageData').data('pageid');
		var endPageId = $('#endPageData').data('pageid');
		
		$("input[name='pageStartNumber']").val($('#startPageData').val());
		$("input[name='pageEndNumber']").val($('#endPageData').val());
		
		$( "input[name='pageStart']" ).val(startPageId);
		$( "input[name='pageEnd']" ).val(endPageId);
		
		$('.page-range-selector').hide();
	});
	
	var bookId = getQueryVariable("bookId");
	
	$('.ajax-page-meta').keypress(function() {
		$('.page-range-selector-btn-confirm').attr('disabled', 'true');
	});
	
	$('.ajax-page-meta').change(function(e) {
		
		var request = {};
		request.bookId = bookId;
		request.dataIndex = $(e.target).val();
		
		$.ajax({
	        type: 'GET',
	        data: request,
	        url: '/page/get',
	        success: function (data, textStatus) {
	        	
	        	if (data.id) {
	        		var imageDom = $('#' + $(e.target).data('imagedomid'));
		        	imageDom.attr('src', data.thumbnailUrl);
		        	
		        	$(e.target).attr('data-pageid', data.id);
		        	
		        	var start = parseInt($('#startPageData').val());
		        	var end = parseInt($('#endPageData').val());
		        	
		        	if (start <= end) {
	        			$('.page-range-selector-btn-confirm').removeAttr('disabled');
		        		$('.page-range-message').html('');
		        	} else {
		        		$('.page-range-message').html('區間錯誤');
		        	}
	        	} else {
	        		var imageDom = $('#' + $(e.target).data('imagedomid'));
		        	imageDom.attr('src', '');
		        	$('.page-range-message').html('找不到該頁');
	        	}
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	    		console.log(textStatus);
	    		console.log(errorThrown);
	    		$('.page-range-message').html('輸入錯誤');
	        }
		});
	});
	
});