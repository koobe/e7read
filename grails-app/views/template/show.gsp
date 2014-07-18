
<%@ page import="kgl.OriginalTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'originalTemplate.label', default: 'OriginalTemplate')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-originalTemplate" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-originalTemplate" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list originalTemplate">
			
				<g:if test="${originalTemplateInstance?.textCount}">
				<li class="fieldcontain">
					<span id="textCount-label" class="property-label"><g:message code="originalTemplate.textCount.label" default="Text Count" /></span>
					
						<span class="property-value" aria-labelledby="textCount-label"><g:fieldValue bean="${originalTemplateInstance}" field="textCount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${originalTemplateInstance?.mediaCount}">
				<li class="fieldcontain">
					<span id="mediaCount-label" class="property-label"><g:message code="originalTemplate.mediaCount.label" default="Media Count" /></span>
					
						<span class="property-value" aria-labelledby="mediaCount-label"><g:fieldValue bean="${originalTemplateInstance}" field="mediaCount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${originalTemplateInstance?.html}">
				<li class="fieldcontain">
					<span id="html-label" class="property-label"><g:message code="originalTemplate.html.label" default="Html" /></span>
					
						<span class="property-value" aria-labelledby="html-label"><g:fieldValue bean="${originalTemplateInstance}" field="html"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${originalTemplateInstance?.group}">
				<li class="fieldcontain">
					<span id="group-label" class="property-label"><g:message code="originalTemplate.group.label" default="Group" /></span>
					
						<span class="property-value" aria-labelledby="group-label"><g:fieldValue bean="${originalTemplateInstance}" field="group"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${originalTemplateInstance?.templateSegment}">
				<li class="fieldcontain">
					<span id="templateSegment-label" class="property-label"><g:message code="originalTemplate.templateSegment.label" default="Template Segment" /></span>
					
						<g:each in="${originalTemplateInstance.templateSegment}" var="t">
						<span class="property-value" aria-labelledby="templateSegment-label"><g:link controller="templateSegment" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:originalTemplateInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${originalTemplateInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
