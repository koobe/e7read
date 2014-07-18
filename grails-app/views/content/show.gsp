<%@ page import="kgl.Content" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<asset:stylesheet src="content_show.scss"/>
	</head>
	<body>
		<div style="width:100%; height:100%">
			
			<!-- FOR TEST -->
			<div class="show-header">
	        	<g:link url="/" class="btn btn-default">Back</g:link>
	        	<span>${title}</span>
	    	</div>
	    	<div>
				<g:render template="/originalTemplate/default_template" model="['pictureSegments': pictureSegments, 'textSegments': textSegments]" />
	    	</div>
	    	<div class="show-header">
	    		END OF CONTENT
	    	</div>
	    	
	    	<br/>
	    	<div class="show-header">
	    		TEST IFRAME
	    	</div>
	    	<iframe src="${createLink(controller: 'content', action: 'embed', id: id)}" width="100%" height="400px" style="border: 1px solid darkgray"/>
		</div>
	</body>
</html>
