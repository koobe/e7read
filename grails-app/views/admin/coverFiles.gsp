<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Default Cover Pictures</title>
</head>

<body>

<div class="container">

    <div class="page-header">
        <div class="btn-group pull-right" role="group">
            <g:link controller="admin" action="dashboard" class="btn btn-default">返回</g:link>
        </div>
        <h2>封面圖片管理</h2>
    </div>

    <g:each in="${files}" var="file">
        <a href="#">
            <img src="${file.url}" alt="cover" class="img-responsive img-thumbnail" style="max-width: 320px;max-height: 240px; float: left"/>
        </a>
    </g:each>

    <div style="clear: both"></div>

    <div class="well">
        <h3>上傳圖片檔</h3>
        <g:uploadForm action="coverFilesUploadSave">
            <div class="form-group">
                <input type="file" accept="image/*" name="file" />
            </div>

            <g:submitButton name="Upload" class="btn btn-default"/>
        </g:uploadForm>
    </div>

</div>


</body>
</html>