
	$(document).ready(function() {
		if (($(window).height() - $("#contents_container").height()) >= 0) {
			triggerAjaxForData();
		}
	});

	var max = 5;
	var page = 1;
	var onCall = false;
	var eof = false;
	
	$(window).scroll(function() {
		if (!eof) {determineIFTriggerAjax();}
	});

	// for mobile
	$('body').on({
	    'touchmove': function(e) { 
	    	if (!eof) {determineIFTriggerAjax();}
	    }
	});

	function determineIFTriggerAjax() {
		var factor = $(window).scrollTop() + $(window).height() + 100;
		
		if (($(document.body).height() - factor) <= 0) {
			triggerAjaxForData();
		}
	}

	function triggerAjaxForData() {
		if (!onCall) {
			onCall = true;
			
			page = page + 1;
			var offset = (page * max) - max;	
			
			if ($('#text-search').val() != '') {
				var searchString = $('#text-search').val();
				data = {'q': searchString, 'from': offset, 'size': max};
			} else {
				data = {'max': max, 'offset': offset};
			}
			
			$.ajax({
				type:'POST',
				data: data,
				url:'/content/renderContentsHTML',
				success:function(data,textStatus){onSuccessAndAppendHTMLToContentContainer(data);},
				error:function(XMLHttpRequest,textStatus,errorThrown){}
			});
		}
	}

	function onSuccessAndAppendHTMLToContentContainer(data) {
		$("#contents_container").append(data);
		onCall = false;
		if (data == "") {
			console.log('EOF');
			eof = true;
		}
	}