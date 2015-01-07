<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <title>系統組態管理</title>
</head>

<body>
<div class="container">

    <div class="page-header">
        <div class="btn-group pull-right" role="group">
            <g:link controller="admin" action="dashboard" class="btn btn-default">返回</g:link>
        </div>
        <h2>系統組態管理</h2>
    </div>

    <g:form controller="admin" action="configUpdateSave" id="${config.id}" method="post" role="form" class="well" name="formConfigUpdate">
        <div class="form-group">
            <label>Config ID</label>
            <p>${config.id}</p>
        </div>

        <div class="form-group">
            <label for="name">Config Name</label>
            <g:textField name="name" value="${config.name}" class="form-control" placeholder="Enter Config Name" />
        </div>

        <div class="form-group">
            <label for="name">Config Content</label>
            <g:textArea name="content" value="${config.content}" class="form-control" placeholder="Enter Config Content" />
        </div>

        <div class="form-group text-right">
            <label>
                <g:checkBox name="delete" /> <span class="text-danger">Delete this config (be careful)!</span>
            </label>
        </div>

        <button type="submit" class="btn btn-primary">Update</button>
        <g:link controller="admin" action="config" class="btn btn-default">Cancel</g:link>
    </g:form>

</div>

<script type="text/javascript">
$(function() {

});
</script>
</body>
</html>