<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>系統組態管理</title>
</head>

<body>

<div class="container">

    <div class="page-header">
        <div class="btn-group pull-right" role="group">
            <button type="button" id="btnConfigAdd" class="btn btn-default">
                <i class="fa fa-plus"></i>
                新增
            </button>
            <g:link controller="admin" action="dashboard" class="btn btn-default">返回</g:link>
        </div>

        <h2>系統組態管理</h2>
    </div>

    <g:form controller="admin" action="configAdd" method="post" role="form" class="well" name="formConfigAdd"
            style="display: none">

        <div class="form-group">
            <label for="configName">Config Name</label>
            <g:textField name="configName" class="form-control" placeholder="Enter Config Name"/>
        </div>

        <div class="form-group">
            <label for="configContent">Content</label>
            <g:textField name="configContent" class="form-control" placeholder="Enter Content"/>
        </div>

        <button type="submit" class="btn btn-primary">Submit</button>
        <button class="btn btn-default" id="btnFormCancel">Cancel</button>
    </g:form>

    <table class="table table-striped table-bordered table-hover table-responsive">
        <thead>
            <tr>
                <th width="30%">Config Name</th>
                <th width="*">Content</th>
            </tr>
        </thead>
        <tbody>
        <g:each in="${configs}" var="config">
            <tr>
                <td>
                    <g:link controller="admin" action="configUpdate" id="${config.id}">
                        ${config.name}
                    </g:link>
                </td>
                <td>
                    <code>${config.content}</code>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(function () {
        $('#btnConfigAdd').click(function () {
            $('#formConfigAdd').show('slow');
            $('#ConfigName').focus();
        });

        $('#btnFormCancel').click(function () {
            $('#formConfigAdd').hide('slow');
            return false;
        });
    });
</script>
</body>
</html>