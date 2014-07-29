<!DOCTYPE html>
<html>
<head>
    <title>${content.cropTitle}</title>
    <meta name="kgl:media_count" content="3"/>
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
        /*font-family: serif;*/
        font-family: "Helvetica Neue",Helvetica,"Heiti TC","微軟正黑體","Microsoft Sans Serif",Helvetica,Geneva,sans-serif;
        font-size: 18px;
        margin-bottom: 20px;
        line-height: 160%;
        letter-spacing: 1px;
    }
    
    h1 {
        font-weight: 700;
       	/*font-family: sans-serif;*/
       	font-family: "Helvetica Neue",Helvetica,"Heiti TC","微軟正黑體","Microsoft Sans Serif",Helvetica,Geneva,sans-serif;
        font-size: 28px;
    }
    
    .main-container {
        width: 100%;
        height: 100%;
    }
    
    .main-content {
        margin: auto;
        max-width: 920px;
        padding-left: 25px;
        padding-right: 25px;
        padding-bottom: 30px;
    }
    
    .content-title {
    	margin-bottom: 0px;
    }
    
    .content-author-div {
    	text-align: left;	
    	border-bottom: 1px solid #94E6DA;
    	margin-bottom: 30px;
    }   
     
    .content-author {
    	font-family: "Helvetica Neue",Helvetica,"Heiti TC","微軟正黑體","Microsoft Sans Serif",Helvetica,Geneva,sans-serif;
        font-size: 18px;
    }
    
    .main-gallery {
    	padding-top: 30px;
        margin: auto;
        display: table;
        border-spacing: 15px 0px;
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
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        box-shadow: 0 1px 2px 1px #ccc;
        width: 33%;
    }
    </style>
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
        <div>
        	<g:each in="${content.textSegments}" var="segment">
                <p style="text-align:justify;">${segment.text}</p>
            </g:each>
        </div>
    </div>
</div>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>
