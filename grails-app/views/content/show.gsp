<%@ page import="kgl.Content" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<asset:stylesheet src="content_show.scss"/>
		<script type="text/javascript">
			function postCloseFrameMessage() {
				if (window != window.parent) {
					window.parent.postMessage('close', "*");
				} else {
					history.back();
				}
			}

			var fontsize = 17;
			function decreaseFontSize() {
				fontsize--;
				$('p').css('font-size', fontsize + 'px');
			}
			function increaseFontSize() {
				fontsize++;
				$('p').css('font-size', fontsize + 'px');
			}
		</script>
	</head>
	<body style="width:100%; height:100%;">
		<div style="height:100%;">
			
			<!-- FOR TEST -->
			<div class="show-header">
	        	<g:link uri="javascript: postCloseFrameMessage();" class="btn btn-default">Back</g:link>
	        	<span>${content.cropTitle}</span>
	        	<g:link uri="javascript: increaseFontSize();" class="btn btn-default pull-right button-margin">A+</g:link>
	        	<g:link uri="javascript: decreaseFontSize();" class="btn btn-default pull-right button-margin">A-</g:link>
	    	</div>
	    	
	    	<g:render template="/template/default_template_embed" bean="${content}"/>
	    	
	    	<!-- 
	    	<iframe src="${createLink(controller: 'content', action: 'embed', id: content.id)}" style="overflow:hidden;overflow-x:hidden;overflow-y:hidden;height:100%;width:100%;z-index:999;" height="100%" width="100%" />
	    	 -->
		</div>
	</body>
</html>
