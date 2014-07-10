
<%@ page import="kgl.Content" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-content" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-content" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list content">
			
				<g:if test="${contentInstance?.cropText}">
				<li class="fieldcontain">
					<span id="cropText-label" class="property-label"><g:message code="content.cropText.label" default="Crop Text" /></span>
					
						<span class="property-value" aria-labelledby="cropText-label"><g:fieldValue bean="${contentInstance}" field="cropText"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contentInstance?.cropTitle}">
				<li class="fieldcontain">
					<span id="cropTitle-label" class="property-label"><g:message code="content.cropTitle.label" default="Crop Title" /></span>
					
						<span class="property-value" aria-labelledby="cropTitle-label"><g:fieldValue bean="${contentInstance}" field="cropTitle"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contentInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="content.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${contentInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${contentInstance?.hasPicture}">
				<li class="fieldcontain">
					<span id="hasPicture-label" class="property-label"><g:message code="content.hasPicture.label" default="Has Picture" /></span>
					
						<span class="property-value" aria-labelledby="hasPicture-label"><g:formatBoolean boolean="${contentInstance?.hasPicture}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${contentInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="content.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${contentInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${contentInstance?.originalTemplate}">
				<li class="fieldcontain">
					<span id="originalTemplate-label" class="property-label"><g:message code="content.originalTemplate.label" default="Original Template" /></span>
					
						<span class="property-value" aria-labelledby="originalTemplate-label"><g:link controller="originalTemplate" action="show" id="${contentInstance?.originalTemplate?.id}">${contentInstance?.originalTemplate?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${contentInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="content.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${contentInstance?.user?.id}">${contentInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:contentInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${contentInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
