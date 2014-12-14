<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>分類管理</title>
</head>

<body>

<div class="container">

    <div class="page-header">
        <div class="btn-group pull-right" role="group">
            <button type="button" id="btnCategoryAdd" class="btn btn-default">
                <i class="fa fa-plus"></i>
                新增
            </button>
            <g:link controller="admin" action="dashboard" class="btn btn-default">返回</g:link>
        </div>

        <h2>分類管理</h2>
    </div>

    <g:form controller="admin" action="categoryAdd" method="post" role="form" class="well" name="formCategoryAdd"
            style="display: none">

        <div class="form-group">
            <label for="categoryName">Category Name</label>
            <g:textField name="categoryName" class="form-control" placeholder="Enter Category Name"/>
        </div>

        <div class="form-group">
            <label for="channelName">Channel Name</label>
            <g:textField name="channelName" class="form-control" placeholder="Enter Channel Name"/>
        </div>

        <button type="submit" class="btn btn-default">Submit</button>
        <button type="submit" class="btn btn-default" id="btnFormCancel">Cancel</button>
    </g:form>

    <table class="table table-striped table-bordered table-hover table-responsive">
        <thead>
            <tr>
                <th width="32">Icon</th>
                <th>Category Name</th>
                <th>Channel Name</th>
                <th>Enabled?</th>
                <th>Order</th>
                <th>Rank On Top</th>
            </tr>
        </thead>
        <tbody>
        <g:each in="${categories}" var="category">
            <tr>
                <td>
                    <img src="${category.iconUrl}" class="img-responsive" />
                </td>
                <td>
                    <g:link controller="admin" action="CategoryUpdate" id="${category.id}">
                        ${category.name}
                    </g:link>
                </td>
                <td>
                    ${category.channel?.name}
                </td>
                <td>
                    ${category.enable}
                </td>
                <td>
                    ${category.order}
                </td>
                <td>
                    ${category.rankOnTop}
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(function () {
        $('#btnCategoryAdd').click(function () {
            $('#formCategoryAdd').show('slow');
            $('#CategoryName').focus();
        });

        $('#btnFormCancel').click(function () {
            $('#formCategoryAdd').hide('slow');
        });
    });
</script>
</body>
</html>