
<%@ page import="kgl.OriginalTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'originalTemplate.label', default: 'OriginalTemplate')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-originalTemplate" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-originalTemplate" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="textCount" title="${message(code: 'originalTemplate.textCount.label', default: 'Text Count')}" />
					
						<g:sortableColumn property="mediaCount" title="${message(code: 'originalTemplate.mediaCount.label', default: 'Media Count')}" />
					
						<g:sortableColumn property="html" title="${message(code: 'originalTemplate.html.label', default: 'Html')}" />
					
						<g:sortableColumn property="group" title="${message(code: 'originalTemplate.group.label', default: 'Group')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${originalTemplateInstanceList}" status="i" var="originalTemplateInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${originalTemplateInstance.id}">${fieldValue(bean: originalTemplateInstance, field: "textCount")}</g:link></td>
					
						<td>${fieldValue(bean: originalTemplateInstance, field: "mediaCount")}</td>
					
						<td>${fieldValue(bean: originalTemplateInstance, field: "html")}</td>
					
						<td>${fieldValue(bean: originalTemplateInstance, field: "group")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${originalTemplateInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
