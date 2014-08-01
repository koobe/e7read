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
	
		<div class="title-container border-btm margin-lr-20">
			<div class="content-title">
	            <h1>${content.cropTitle}</h1>
	        </div>
	        <div style="display:table; width:100%;">
		        <div class="content-author" style="display:table-cell;">
		        	<span>${content.user.fullName}</span>
		        </div>
		        <div class="content-author" style="display:table-cell; text-align: right;">
		        	<span style="font-size: 0.7em; color: #333;"><g:formatDate date="${content.lastUpdated}" format="yyyy/MM/dd HH:mm:ss" /></span>
		        </div>
	        </div>
		</div>
		
		<div class="margin-blank"></div>
	    
	    <div class="main-gallery">
	        <div class="table-row">
	            <g:each in="${content.pictureSegments}">
	                <div class="table-col" style="background-image:url(${it.originalUrl});"></div>
	            </g:each>
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
	    
	    <div class="margin-blank"></div>
	    
	    <g:if test="${content.references}">
	    	<div class="text-references padding-lr" style="overflow: hidden; text-overflow:ellipsis; white-space: nowrap; color: #555;">
	    		<i class="fa fa-external-link"></i>
	    		<g:link uri="${createLink(uri: content.references)}" target="_blank">Source</g:link>
	    		${content.references}
	    	</div>
	    </g:if>
	    
	</div>
	
	<g:render template="/home/footer" />
</body>
</html>
