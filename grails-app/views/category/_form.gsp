<%@ page import="kgl.Category" %>



<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="category.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${categoryInstance?.name}"/>


    <label for="label">
        <g:message code="category.label.label" default="Label" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="label" required="" value="${categoryInstance?.label}"/>

</div>

