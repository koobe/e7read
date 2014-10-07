<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js"><!--<![endif]-->
<head>
	
	<title>${content.cropTitle}</title>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, minimal-ui" />

    <g:if test="${System.getenv('ENV')?.equals('development') || System.getProperty('ENV').equals('development')}">
		<meta name="robots" content="noindex">
	</g:if>
    <g:each in="${params}">
    	<meta name="params-${it.key}" content="${it.value}"/>
    </g:each>
    <meta name="params-channel" content="${channel}"/>

    <link rel="shortcut icon" href="${assetPath(src: 'webicon.png')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'webicon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'webicon.png')}">
    
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <asset:stylesheet src="header.css"/>

	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet"/>

	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script src="//soapbox.github.io/jQuery-linkify/dist/jquery.linkify.min.js"></script>    
	
	<asset:javascript src="application.js" />
    
    <asset:stylesheet src="imageview.css"/>
	<asset:javascript src="jquery.imageview.js"/>

	<asset:stylesheet src="gototop.css"/>
	<asset:javascript src="jquery.gototop.js"/>
	
	<asset:stylesheet src="e7read_categorystatus.css" />
	<asset:javascript src="jquery.e7read.categorystatus.js"/>
	
	<asset:stylesheet src="default_template.css"/>
	<asset:javascript src="default_template.js"/>
    
    <g:render template="/home/google_analytics" />
    
    <g:layoutHead/>
</head>
<body data-linkify="p, .plain-text" id="content-body">
	<fb:init/>
	<g:layoutBody/>
	<g:render template="/home/footer"/>
</body>
</html>
