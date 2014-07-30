<!DOCTYPE html>
<html>
<head>
    <title>${content.cropTitle}</title>
    <meta name="kgl:media_count" content="3"/>
    <meta name="kgl:text_count" content="1"/>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <asset:stylesheet src="default_template.css"/>
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
    
    <div class="vcard-container padding-lr">
    	<div class="vcard-cell-body">
    		<div class="content-contact">
			    <ul class="basic">
			        <li class="avatar"><img src="//graph.facebook.com/${content.user.facebookId}/picture" alt="facebook-avatar" /></li>
			        <li class="fullName">${content.user.fullName}</li>
			    </ul>
			    <ul class="advanced">
			    	<g:if test="${content.user.email}">
			        	<li class="email">Email: ${content.user.email}</li>
			        </g:if>
			        <g:if test="${content.user.contact?.phone}">
			        	<li class="phone">Phone: ${content.user.contact?.phone}</li>
			        </g:if>
			        <g:if test="${content.user.contact?.skypeId}">
			        	<li class="phone"> Skype: ${content.user.contact?.skypeId}</li>
			        </g:if>
			        <g:if test="${content.user.contact?.lineId}">
			        	<li class="lineId">Line: ${content.user.contact?.lineId}</li>
			        </g:if>
			    </ul>
			</div>
    	</div>
    </div>
</div>
</body>
</html>
