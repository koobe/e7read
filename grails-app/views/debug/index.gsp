<html>
<head>
    <meta name="layout" content="main"/>
    <title>Debug</title>
</head>

<body>

<div class="container">
    <div class="page-header">
        <h1>Debug</h1>
    </div>

    <p>Select an action:</p>

    <ul>
        <g:each in="${actions}" var="action">
            <li><g:link action="${action}">${action}</g:link></li>
        </g:each>
    </ul>
</div>


</body>
</html>