<!DOCTYPE html>
<html>
<head>
<title>E7READ - Convergence to a better world</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />

<meta name="application-name" content="${meta(name: 'app.name')}"/>
<meta name="application-version" content="${meta(name: 'app.version')}"/>
<meta name="grails-version" content="${meta(name: 'app.grails.version')}"/>
<g:if test="${System.getenv('ENV')?.equals('development') || System.getProperty('ENV').equals('development')}">
    <meta name="robots" content="noindex">
</g:if>

<g:each in="${params}">
    <meta name="params-${it.key}" content="${it.value}"/>
</g:each>

<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.4/jquery.mobile-1.4.4.min.css" />
<!--<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>-->
<asset:javascript src="jquery.js"/>
<asset:javascript src="google_maps_styles.js"/>
<script src="http://code.jquery.com/mobile/1.4.4/jquery.mobile-1.4.4.min.js"></script>
<g:layoutHead />
<style type="text/css">
.map-container {
    text-shadow: none !important;
}
.map-container label {
    display: inline;
    margin: 0;
    font-size: 100%;
}
</style>
</head>
<body>
<g:layoutBody/>
</body>
</html>