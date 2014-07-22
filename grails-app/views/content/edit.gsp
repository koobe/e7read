<%@ page import="kgl.Content" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <style type="text/css">
        div.maximized { position:fixed; top:0; left:0; width:100%; height:100%; }
        div.maximized iframe { width:100%; height:100%; border:0 none; padding-top: 50px }
    </style>
</head>
<body>

<div class="maximized">
    <iframe class="iframe-embed" src="${createLink(controller: 'content', action: 'embed', id: contentInstance.id, params: [template: template?.name])}" width="100%" height="800px" frameborder="0" ></iframe>
</div>

<div style="position: fixed; padding: 5px 0 0 5px">
    <!--${contentInstance}-->
    <g:form action="edit" id="${contentInstance.id}" class="form-inline" role="form" method="get">
        <g:select class="form-control" name="template" from="${kgl.OriginalTemplate.list()}" value="${template?.name}" optionKey="name" optionValue="name" />
        <button class="form-control" type="submit">Apply</button>
    </g:form>
</div>

<script type="text/javascript">
$(function() {
    $('.iframe-embed').size();
});
</script>

</body>
</html>
