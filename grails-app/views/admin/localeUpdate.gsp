<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <title>翻譯管理</title>
</head>

<body>
<div class="container">

    <div class="page-header">
        <div class="btn-group pull-right" role="group">
            <g:link controller="admin" action="dashboard" class="btn btn-default">返回</g:link>
        </div>
        <h2>翻譯管理</h2>
    </div>

    <g:form controller="admin" action="localeUpdateSave" method="post" role="form" class="well" name="formChannelUpdate">

        <g:hiddenField name="group" value="${group}" />
        <g:hiddenField name="code" value="${code}" />

        <div class="form-group">
            <label>Group</label>
            <p>${group}</p>
        </div>

        <div class="form-group">
            <label>Code</label>
            <p>${code}</p>
        </div>

        <g:each in="${locales}" var="lc">
            <div class="form-group">
                <label for="name">${lc.tag} - ${lc.display}</label>
                <g:hiddenField name="lang[]" value="${lc.tag}" />
                <g:textArea name="content[]" value="${lc.locale?.content}" class="form-control" />
            </div>
        </g:each>

        <div class="form-group text-right">
            <label>
                <g:checkBox name="delete" /> <span class="text-danger">Check to delete this locale.</span>
            </label>
        </div>

        <button type="submit" class="btn btn-primary">Update</button>
        <g:link controller="admin" action="locale" params="[group: group]" class="btn btn-default">Cancel</g:link>
    </g:form>

</div>

<script type="text/javascript">
$(function() {

});
</script>
</body>
</html>