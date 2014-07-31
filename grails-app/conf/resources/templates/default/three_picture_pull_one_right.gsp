<!DOCTYPE html>
<html>
<head>
    <title>${content.cropTitle}</title>
    <meta name="kgl:media_count" content="3"/>
    <meta name="kgl:text_count" content="1"/>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <asset:stylesheet src="default_template.css"/>
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
<div class="template-container">

    <div class="pictures-container">
    	<table class="picture-rtable">
			<tr>
			  <td>
				<div class="picture-native" style="background-image:url(${content.pictureSegments[0]?.originalUrl});"></div>
			  </td>
			  <td rowspan="2">
			  	<div class="picture-native" style="background-image:url(${content.pictureSegments[1]?.originalUrl});"></div>
			  </td>
			</tr>
			<tr>
			  <td>
			  	<div class="picture-native" style="background-image:url(${content.pictureSegments[2]?.originalUrl});"></div>
			  </td>
			</tr>
		</table>
	</div>
	
	<div class="title-container border-btm margin-lr-20">
		<div class="content-title">
            <h1>${content.cropTitle}</h1>
        </div>
        <div class="content-author">
        	<span>${content.user.fullName}</span>
        </div>
	</div>
	
	<div class="margin-blank"></div>
	
    <div class="text-container padding-lr">
        <div>
        	<g:each in="${content.textSegments}" var="segment">
                <p style="text-align:justify;">${segment.text}</p>
            </g:each>
        </div>
    </div>
    
</div>
<g:render template="/home/footer" />
</body>
</html>
