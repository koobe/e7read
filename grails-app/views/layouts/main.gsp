<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>E7READ - Convergence to a better world</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, minimal-ui" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="apple-mobile-web-app-capable" content="yes" />

    <meta name="application-name" content="${meta(name: 'app.name')}"/>
    <meta name="application-version" content="${meta(name: 'app.version')}"/>
    <meta name="grails-version" content="${meta(name: 'app.grails.version')}"/>

    <g:each in="${params}"><meta name="params-${it.key}" content="${it.value}"/>
    </g:each>

    <link rel="shortcut icon" href="${assetPath(src: 'webicon.png')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'webicon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'webicon.png')}">
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <asset:stylesheet src="header.css"/>
    <g:layoutHead/>

    <!-- FontAwesome -->
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

    <style type="text/css">
    html, body {
        width: 100%;
        height: 100%;
    }
    </style>
    
    <g:render template="/home/google_analytics" />
</head>

<body>
<g:layoutBody/>
<div class="footer" role="contentinfo"></div>

<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>

</body>
</html>
