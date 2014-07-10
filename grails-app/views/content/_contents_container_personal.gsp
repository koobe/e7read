<style>
<!--
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
		margin-left: 0px;
		margin-right: 0px;
	}
	
	.editing-title:focus {
		border: 1px solid #ccc;
		border-radius: 5px;
		transition: border-color ease-in-out .10s;
	}
	
	.resetmargin {
		margin-top: 0px;
		margin-bottom: 0px;
		margin-left: 0px;
		margin-right: 0px;
	}
	
	.item-editing-menu {
        background: rgba(0,0,0,0.5);
        width: auto;
        height: auto;
        padding: 5px;
        position: absolute;
        bottom: 5px;
        right: 20px;
        color: #fff;
        display: none;
	}
	
	#testdiv {
        background: rgba(0,0,0,0.5);
        width: auto;
        height: auto;
        padding: 5px;
        position: fixed;
        top: 0px;
        left: 0px;
        color: #fff;
        z-index: 999;
	}
-->
</style>
<script type="text/javascript">

	$(document).ready(function() {
		if (($(window).height() - $("#contents_container").height()) >= 0) {
			triggerAjaxForData();
		}
	});
	
	var max = 4;
	var page = 1;
	var onCall = false;
	var eof = false;
	var beforeText;
	
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
				url:'/content/renderPersonalContentsHTML',
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
		} else {
			addHandlers();
		}
	}

	function addHandlers() {

		$('.hovercontent').unbind('hover');
		$('.hovercontent').hover(
		    function () {
		        $(this).find('.item-editing-menu').show(250);
		    }, 
		    function () {
		        $(this).find('.item-editing-menu').hide(250);
		    }
		);

		$('.editing-title').unbind('focus');
		$('.editing-title').focus(function() {
			beforeText = $(this).text();
		});

		$('.editing-title').unbind('blur');
		$('.editing-title').blur(function() {
			if ($(this).text() != beforeText) {
				$.ajax({
					type:'POST',
					data: { 'contentid': $(this).attr('contentid'), 'title': $(this).text() },
					url:'/content/updateTitle',
					success:function(data,textStatus){},
					error:function(XMLHttpRequest,textStatus,errorThrown){}
				});
			}
		});

		$('.editing-title').unbind('keydown');
		$('.editing-title').keydown(function(event){
			if ( event.which == 13 ) {
				$(this).blur();
			}
		});
	}

	function deleteContent(contentid) {
		var r = confirm('Want to delete?');
		if (r == true) {
			$.ajax({
				type:'POST',
				data: { 'contentid': contentid },
				url:'/content/disableContent',
				success:function(data,textStatus){$("div[contentid='"+ contentid +"']").remove();},
				error:function(XMLHttpRequest,textStatus,errorThrown){}
			});
		}
	}
</script>
<div id="contents_container" class="container-fluid maincontainer">
	
	<g:include controller="content" action="renderPersonalContentsHTML" params="[max:4, offset:0]" />
	<script type="text/javascript">
		addHandlers();
	</script>
</div>