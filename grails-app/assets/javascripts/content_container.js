
var s = $.spinner();

	$(document).ready(function() {
		if (($(window).height() - $("#contents_container").height()) >= 0) {
			triggerAjaxForData();
		}
		
		//$('body').css('height', 'auto');
	});

	var max = 5;
	var page = 0;
	var onCall = false;
	var eof = false;

    $(function() {
        $('#display-container')
            .scroll(function() {
                if (!eof) {determineIFTriggerAjax();}
            })
            .on({
                'touchmove': function(e) {
                    if (!eof) {determineIFTriggerAjax();} // for mobile
                }
            });
    });

	function determineIFTriggerAjax() {

        var scrollContainer = $('#display-container');
        var contentPane = $('#display-container .content-pane');

		var factor = scrollContainer.scrollTop() + scrollContainer.height() + 100;
		
		//console.log('scrollContainer.scrollTop()  ' + scrollContainer.scrollTop());
		//console.log('$(window).height()  ' + $(window).height());
		//console.log('factor  ' + factor);
		//console.log('$(document.body).height()  ' + $(document.body).height());
        //console.log('$(\'#display-container\').height()  ' + $('#display-container').height());
        //console.log(contentPane.height());
		
		if ((contentPane.height() - factor) <= 0) {
			triggerAjaxForData();
		}
	}

	function triggerAjaxForData() {
		if (!onCall) {
			
			s.loading();
			
			onCall = true;

//            $('.copyright-text').text($('.copyright-text').data('text-onload'));
			
			page = page + 1;
			var offset = (page * max) - max;	
			
			var c = getQueryVariable("c");
			var u = getQueryVariable("u");
			
			if ($('#text-search').val() != '') {
				var searchString = $('#text-search').val();
				data = {'q': searchString, 'from': offset, 'size': max};
			} else if (c) {
				data = {'c': c, 'max': max, 'offset': offset};
			} else if (u) {
				data = {'u': u, 'max': max, 'offset': offset};
			} else {
				data = {'max': max, 'offset': offset};
			}
			
			$.ajax({
				type:'POST',
				data: data,
				url:'/content/renderContentsHTML',
				success:function(data,textStatus){
					onSuccessAndAppendHTMLToContentContainer(data);
//                    $('.copyright-text').text($('.copyright-text').data('text-original'));
				},
				error:function(XMLHttpRequest,textStatus,errorThrown){}
			});
		}
	}

	function onSuccessAndAppendHTMLToContentContainer(data) {
		var dataobj = $(data);
		onCall = false;
		if (data == "") {
			console.log('EOF');
			eof = true;
		} else {
			$("#contents_container").append(dataobj);
			
			$('.content-cell-image', dataobj).imageview({
				attrOfUrl: 'data-imageurl'
			});
			
			$('.content-author-name', dataobj).click(onAuthorClick);
			$('.content-category-name', dataobj).click(onCategoryTagClick);
		}
		s.done();
	}
	
	var onAuthorClick = function(event) {
		console.log('author name clicked!!' + event.target);
		var userId = $(event.target).data('user');
		location.href = "?u=" + userId;
		event.stopPropagation();
	}
	
	var onCategoryTagClick = function(event) {
		var c = $(event.target).data('categoryname');
		location.href = "?c=" + c;
		event.stopPropagation();
	}