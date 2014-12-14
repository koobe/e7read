<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>翻譯管理</title>
</head>

<body>

<div class="container">

    <div class="page-header">
        <div class="btn-group pull-right" role="group">
            <button type="button" id="btnLocaleAdd" class="btn btn-default">
                <i class="fa fa-plus"></i>
                新增
            </button>
            <g:link controller="admin" action="dashboard" class="btn btn-default">返回</g:link>
        </div>

        <h2>翻譯管理</h2>
    </div>

    <g:form controller="admin" action="localeAdd" method="post" role="form" class="well" name="formLocaleAdd"
            style="display: none">

        <div class="form-group">
            <label for="group">Group</label>
            <g:textField name="group" class="form-control" />
        </div>

        <div class="form-group">
            <label for="code">Code</label>
            <g:textField name="code" class="form-control" />
        </div>

        <div class="form-group">
            <label for="lang">Language</label>
            <g:textField name="lang" class="form-control" />
        </div>

        <div class="form-group">
            <label for="content">Content</label>
            <g:textField name="content" class="form-control" />
        </div>

        <button type="submit" class="btn btn-default">Submit</button>
        <button class="btn btn-default" id="btnFormCancel">Cancel</button>
    </g:form>

    <table class="table table-striped table-bordered table-hover table-responsive">
        <thead>
            <tr>
                <th>Group</th>
                <th>Code</th>
                <th>Language</th>
                <th>Content</th>
            </tr>
        </thead>
        <tbody>
        <g:each in="${locales}" var="locale">
            <tr>
                <td>
                    ${locale.group}
                </td>
                <td>
                    ${locale.code}
                </td>
                <td>
                    ${locale.lang}
                </td>
                <td>
                    ${locale.content}
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(function () {
        $('#btnLocaleAdd').click(function () {
            $('#formLocaleAdd').show('slow');
            $('#localeName').focus();
        });

        $('#btnFormCancel').click(function () {
            $('#formLocaleAdd').hide('slow');
            return false;
        });
    });
</script>
</body>
</html>