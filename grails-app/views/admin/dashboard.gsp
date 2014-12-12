<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <title>管理介面</title>
</head>

<body>

<div class="container">

    <div class="page-header">
        <h2>管理介面</h2>
    </div>

    <div class="list-group">
        <g:link controller="admin" action="coverFiles" class="list-group-item">
            <i class="fa fa-file-image-o"></i>
            預設封面圖片
        </g:link>
        <g:link controller="admin" action="channel" class="list-group-item">
            <i class="fa fa-magnet"></i>
            頻道管理
        </g:link>
        <g:link controller="admin" action="category" class="list-group-item">
            <i class="fa fa-list-ul"></i>
            分類管理
        </g:link>
        <g:link uri="#" class="list-group-item">
            <i class="fa fa-globe"></i>
            翻譯管理
        </g:link>
    </div>
</div>


</body>
</html>