<!DOCTYPE html> 
<html style="width:100%; height:100%;"> 
<head> 
    <title>Default Template</title>
    <link rel="stylesheet" href="/assets/bootstrap.css?compile=false"  />
    <style type="text/css">
    	@import url(http://fonts.googleapis.com/earlyaccess/cwtexfangsong.css);
    	p {
    		font-family: 'cwTeXFangSong', serif;
			font-size: 17px;
    	}
    </style>
</head> 
<body style="width:100%; height:100%;">
	<div style="width:100%; height:100%;">
		<div style=" display: table; border-spacing: 5px;width:100%; height:50%; border: 1px solid #ccc;">
			<div style="display: table-row; border: 1px solid red;">
				<g:each in="${it.pictureSegments}" var="segment">
					<div style="display: table-cell; height:100%; border-radius: 5px; border: 1px solid #ccc; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${segment.originalUrl});"></div>
				</g:each>
			</div>
		</div>
		<div>
			<div style="padding:5px;">
				<g:each in="${it.textSegments}" var="segment">
					<p style="text-align:justify;">${segment.text}</p>
				</g:each>
			</div>
		</div>
	</div>
</body> 
</html>