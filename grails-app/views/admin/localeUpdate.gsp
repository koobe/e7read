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

    <g:form controller="admin" action="localeUpdateSave" id="${code}" method="post" role="form" class="well" name="formChannelUpdate">
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

        <button type="submit" class="btn btn-primary">Update</button>
        <g:link controller="admin" action="locale" class="btn btn-default">Cancel</g:link>
    </g:form>

</div>

<script type="text/javascript">
$(function() {

});
</script>
</body>
</html>