<%@ page import="kgl.OriginalTemplate" %>



<div class="fieldcontain ${hasErrors(bean: originalTemplateInstance, field: 'textCount', 'error')} required">
	<label for="textCount">
		<g:message code="originalTemplate.textCount.label" default="Text Count" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="textCount" type="number" value="${originalTemplateInstance.textCount}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: originalTemplateInstance, field: 'mediaCount', 'error')} required">
	<label for="mediaCount">
		<g:message code="originalTemplate.mediaCount.label" default="Media Count" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="mediaCount" type="number" value="${originalTemplateInstance.mediaCount}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: originalTemplateInstance, field: 'html', 'error')} required">
	<label for="html">
		<g:message code="originalTemplate.html.label" default="Html" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="html" required="" value="${originalTemplateInstance?.html}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: originalTemplateInstance, field: 'group', 'error')} required">
	<label for="group">
		<g:message code="originalTemplate.group.label" default="Group" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="group" required="" value="${originalTemplateInstance?.group}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: originalTemplateInstance, field: 'templateSegment', 'error')} ">
	<label for="templateSegment">
		<g:message code="originalTemplate.templateSegment.label" default="Template Segment" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${originalTemplateInstance?.templateSegment?}" var="t">
    <li><g:link controller="templateSegment" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="templateSegment" action="create" params="['originalTemplate.id': originalTemplateInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'templateSegment.label', default: 'TemplateSegment')])}</g:link>
</li>
</ul>


</div>

