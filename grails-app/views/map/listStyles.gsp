<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>All map styles</title>
</head>
<body>

<div class="container">
    <g:each in="${styles}" var="style">
        <div class="row">
            <div class="col-md-6">
                <img src="/mapStyle/${style.name}.png" class="img-responsive img-thumbnail" />
            </div>
            <div class="col-md-6">
                <h3>${style.name}</h3>
                <g:link controller="map" action="explore" params="[mapStyle: style.name]">
                    ${createLink(controller: 'map', action: 'explore', params: [mapStyle: style.name])}
                </g:link>
            </div>
        </div>
        <hr class="soften" />
    </g:each>
</div>

</body>
</html>