<style>
	.hovercontent {
		padding: 5px;
		border: 1px solid #fff;
	}
	.hovercontent:hover {
		padding: 5px;
		border: 1px solid #ccc;
		border-radius: 5px;
		box-shadow:2px 2px 2px 1px rgba(0,0,0,.075);
		transition: border-color ease-in-out .10s,box-shadow ease-in-out .1s;
	}
	.maincontainer {
		margin-left: 15px;
		margin-right: 15px;
	}
</style>
<script type="text/javascript">

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
			page = page + 1;
			var offset = (page * max) - max;				
			onCall = true;
			$.ajax({
				type:'POST',
				data: { 'max': max, 'offset': offset },
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
</script>
<div id="contents_container" class="container-fluid maincontainer">
	<g:include controller="content" action="renderContentsHTML" params="[max:5, offset:0]" />
</div>