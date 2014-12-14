<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <title>分類資料維護</title>
</head>

<body>
<div class="container">

    <div class="page-header">
        <div class="btn-group pull-right" role="group">
            <g:link controller="admin" action="category" class="btn btn-default">返回</g:link>
        </div>
        <h2>分類資料維護</h2>
    </div>

    <g:form controller="admin" action="categoryUpdateSave" id="${category.id}" method="post" role="form" class="well" name="formChannelUpdate">
        <div class="form-group">
            <label>Category ID</label>
            <p>${category.id}</p>
        </div>

        <div class="form-group">
            <label for="name">Category Name</label>
            <g:textField name="name" value="${category.name}" class="form-control" placeholder="Enter Category Name" />
        </div>

        <div class="form-group">
            <label for="rankOnTop">Rank on Top</label>
            <g:textField name="rankOnTop" value="${category.rankOnTop}" class="form-control" />
        </div>

        <div class="form-group">
            <label for="order">Order</label>
            <g:textField name="order" value="${category.order}" class="form-control" />
        </div>

        <div class="form-group">
            <label for="name">Icon URL</label>
            <g:textField name="iconUrl" value="${category.iconUrl}" class="form-control" />
        </div>

        <div class="form-group">
            <label for="enable">Enabled?</label>
            <div>
                <g:radioGroup values="[true,false]" value="${category.enable}" labels="['Yes','No']" name="enable">
                    <label>
                        ${it.radio} ${it.label}
                    </label>
                </g:radioGroup>
            </div>
        </div>

        <div class="form-group text-right">
            <label>
                <g:checkBox name="delete" /> <span class="text-danger">Delete this category (be careful)!</span>
            </label>
        </div>

        <button type="submit" class="btn btn-default">Update</button>
        <g:link controller="admin" action="category" class="btn btn-default">Cancel</g:link>
    </g:form>

</div>

<script type="text/javascript">
$(function() {

});
</script>
</body>
</html>