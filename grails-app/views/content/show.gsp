<%@ page import="kgl.Content" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

    <div class="">
        <g:link url="/" class="btn btn-default">Home</g:link>
    </div>

    <iframe src="${createLink(controller: 'content', action: 'embed', id: contentInstance.id)}" width="100%" height="400px" style="border: 1px solid darkgray"/>

	</body>
</html>
