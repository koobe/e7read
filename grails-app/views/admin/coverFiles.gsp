<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Default Cover Pictures</title>
</head>

<body>

<div class="container">

    <div class="page-header">
        <h2>List</h2>
    </div>

    <g:each in="${files}" var="file">
        <a href="#">
            <img src="${file.url}" alt="cover" class="img-responsive img-thumbnail" style="max-width: 320px;max-height: 240px; float: left"/>
        </a>
    </g:each>
    <div style="clear: both"></div>

    <div class="page-header">
        <h2>Upload</h2>
    </div>

    <g:uploadForm action="coverFilesUploadSave">
        <div class="form-group">
            <input type="file" accept="image/*" name="file" />
        </div>

        <g:submitButton name="Upload" class="btn btn-default"/>
    </g:uploadForm>


</div>


</body>
</html>