<html>
<head>
    <meta name="kgl:media_count" content="0"/>
    <meta name="kgl:text_count" content="1"/>
    <link rel="stylesheet" href="/assets/bootstrap.css?compile=false"/>
    <title>Content template: three_picture_horizontal</title>
    <style type="text/css">

    body {
        -epub-writing-mode: vertical-rl;
    }

    .template-container {
        width: 100%;
        height: 100%;
    }

    .text-container {
        padding-left: 20px;
        padding-right: 20px;
        padding-bottom: 30px;
    }

    .content-author {
        border-bottom: 1px solid #a9c6e6;
    }

    .content-text {
        margin-top: 10px;
    }

    p {
        font-size: 17px;
        text-align: justify;
        font-family: "Helvetica Neue",Helvetica,"Heiti TC","微軟正黑體","Microsoft Sans Serif",Helvetica,Geneva,sans-serif;
    }
    </style>
</head>

<body>
<div class="template-container">

    <div class="text-container">
        <div class="content-title">
            <h2>${content.cropTitle}</h2>
        </div>

        <div class="content-author">
            <h4>${content.user?.fullName}</h4>
        </div>

        <div class="content-text">
            <g:each in="${content.textSegments}" var="segment">
                <p>${segment.text}</p>
            </g:each>
        </div>
    </div>
    <div><br/><br/></div>
</div>
</body>
</html>