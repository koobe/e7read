<!DOCTYPE html>
<html>
<head>
    <title>${content.cropTitle}</title>
    <meta name="kgl:media_count" content="2"/>
    <meta name="kgl:text_count" content="1"/>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
    @import url(http://fonts.googleapis.com/earlyaccess/cwtexfangsong.css);
    @import url(http://fonts.googleapis.com/earlyaccess/cwtexming.css);
    @import url(http://fonts.googleapis.com/earlyaccess/cwtexhei.css);
    html, body {
        width: 100%;
        height: 100%;
    }
    p {
        font-family: serif;
        font-size: 18px;
        margin-bottom: 15px;
        line-height: 150%;
    }
    h1 {
        /* font-weight: bold; */
        font-family: sans-serif;
        font-size: 28px;
    }
    .main-container {
        width: 100%;
        height: 100%;
    }
    .main-content {
        margin: auto;
        max-width: 920px;
        padding: 20px;
    }
    .main-gallery {
        margin: auto;
        display: table;
        border-spacing: 5px;
        width:100%;
        height:50%;
        max-width: 900px;
    }
    .table-row {
        display: table-row;
    }
    .table-col {
        display: table-cell;
        height:100%;
        border-radius: 5px;
        border: 1px solid #ccc;
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
    }
    </style>
</head>
<body>
<div class="main-container">
    <div class="main-gallery">
        <div class="table-row">
            <div class="table-col" style="width: 70%; background-image:url(${content.pictureSegments[0]?.originalUrl});"></div>
            <div class="table-col" style="width: 30%; background-image:url(${content.pictureSegments[1]?.originalUrl});"></div>
        </div>
    </div>
    <div class="main-content">
        <div style="padding:7px;">
            <h1>${content.cropTitle}</h1>
        </div>
        <div>
            <div style="padding:7px;">
                <g:each in="${content.textSegments}" var="segment">
                    <p style="text-align:justify;">${segment.text}</p>
                </g:each>
            </div>
        </div>
    </div>
</div>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>
