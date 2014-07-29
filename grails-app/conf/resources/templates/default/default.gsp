<!DOCTYPE html>
<html>
<head>
    <title>${content.cropTitle}</title>
    <meta name="kgl:media_count" content="3"/>
    <meta name="kgl:text_count" content="1"/>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <asset:stylesheet src="default_template.css"/>
</head>
<body>
<div class="main-container">
    <div class="main-gallery">
        <div class="table-row">
            <g:each in="${content.pictureSegments}">
                <div class="table-col" style="background-image:url(${it.originalUrl});"></div>
            </g:each>
        </div>
    </div>
    <div class="main-content">
        <div class="content-title">
            <h1>${content.cropTitle}</h1>
        </div>
        <div class="content-author-div">
        	<span class="content-author">${content.user.fullName}</span>
        </div>
        <div class="context-text">
        	<g:each in="${content.textSegments}" var="segment">
                <p style="text-align:justify;">${segment.text}</p>
            </g:each>
        </div>
    </div>
</div>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>
