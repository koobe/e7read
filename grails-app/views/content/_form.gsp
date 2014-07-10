<%@ page import="kgl.Content" %>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'cropTitle', 'error')} required">
	<label for="cropTitle">
		<g:message code="content.cropTitle.label" default="Crop Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField class="form-control" name="cropTitle" required="" value="${contentInstance?.cropTitle}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'cropText', 'error')} required">
	<label for="cropText">
		<g:message code="content.cropText.label" default="Crop Text" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField class="form-control" name="cropText" required="" value="${contentInstance?.cropText}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'coverUrl', 'error')} ">
	<label for="coverUrl">
		<g:message code="content.coverUrl.label" default="Cover URL" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField class="form-control" name="coverUrl" required="" value="${contentInstance?.coverUrl}"/>
</div>



<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'hasPicture', 'error')} ">
	<label for="hasPicture">
		<g:message code="content.hasPicture.label" default="Has Picture" />
		
	</label>
	<g:checkBox name="hasPicture" value="${contentInstance?.hasPicture}" />

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'originalTemplate', 'error')} required">
	<label for="originalTemplate">
		<g:message code="content.originalTemplate.label" default="Original Template" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="originalTemplate" name="originalTemplate.id" from="${kgl.OriginalTemplate.list()}" optionKey="id" required="" value="${contentInstance?.originalTemplate?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: contentInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="content.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${kgl.User.list()}" optionKey="id" required="" value="${contentInstance?.user?.id}" class="many-to-one"/>

</div>

