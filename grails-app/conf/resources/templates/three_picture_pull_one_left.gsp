<!DOCTYPE html> 
<html style="width:100%; height:100%;"> 
<head>
	<meta name="kgl:media_count" content="3"/> 
	<meta name="kgl:text_count" content="1" /> 
    <title>three_picture_right_vertical</title>
    <link rel="stylesheet" href="/assets/bootstrap.css?compile=false"  />
    <style type="text/css">
    	@import url(http://fonts.googleapis.com/earlyaccess/cwtexfangsong.css);
    	p {
    		font-family: 'cwTeXFangSong', serif;
			font-size: 17px;
    	}
    	h1 {
    		font-weight: bold;
    		font-family: 'cwTeXFangSong', serif;
    	}
    </style>
</head> 
<body style="width:100%; height:100%;">
	<div style="width:100%; height:100%;">
		<div style="display: table; border-spacing: 5px; width:100%; height:70%;">
			<div style="display: table-row; border: 1px solid red;">
				<div style="display: table-cell; width:35%; height:100%; border-radius: 5px; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${content.pictureSegments[0].originalUrl});"></div>
				<div style="display: table-cell; width:65%; height:100%; ">
					<div style="width:100%; height:100%;">
						<div style="width:100%; height:49%; border-radius: 5px; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${content.pictureSegments[1].originalUrl});"></div>
						<div style="height: 5px;"></div>
						<div style="width:100%; height:49%; border-radius: 5px; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${content.pictureSegments[2].originalUrl});"></div>
					</div>
				</div>
			</div>
		</div>
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
</body>
</html>