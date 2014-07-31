<!DOCTYPE html>
<html>
<head>
    <title>${content.cropTitle}</title>
    <meta name="kgl:media_count" content="3"/>
    <meta name="kgl:text_count" content="1"/>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">
    @import url(http://fonts.googleapis.com/earlyaccess/cwtexfangsong.css);
    @import url(http://fonts.googleapis.com/earlyaccess/cwtexming.css);
    @import url(http://fonts.googleapis.com/earlyaccess/cwtexhei.css);
    html, body {
        width: 100%;
        height: 100%;
    }
    p {
        font-family: "Helvetica Neue",Helvetica,"Heiti TC","微軟正黑體","Microsoft Sans Serif",Helvetica,Geneva,sans-serif;
        font-size: 18px;
        margin-bottom: 20px;
        line-height: 160%;
        letter-spacing: 1px;
    }
    h1 {
        font-weight: 700;
       	font-family: "Helvetica Neue",Helvetica,"Heiti TC","微軟正黑體","Microsoft Sans Serif",Helvetica,Geneva,sans-serif;
        font-size: 28px;
    }
    .main-container {
        width: 100%;
        height: 100%;
    }
    .main-content {
        margin: auto;
        margin-left: 30%;
        max-width: 920px;
        padding: 20px;
    }
    .main-gallery {
        position: fixed;
        margin: auto;
        display: table;
        border-spacing: 5px;
        width: 30%;
        height: 100%;
    }
    .table-row {
        display: table-row;
    }
    .table-col {
        display: table-cell;
        width: 100%;
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
            <div class="table-col" style="background-image:url(${content.pictureSegments[0]?.originalUrl});"></div>
        </div>
        <div class="table-row">
            <div class="table-col" style="background-image:url(${content.pictureSegments[1]?.originalUrl});"></div>
        </div>
        <div class="table-row">
            <div class="table-col" style="background-image:url(${content.pictureSegments[2]?.originalUrl});"></div>
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
