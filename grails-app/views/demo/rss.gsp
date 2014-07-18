<html>
<head>
    <meta name="layout" content="main"/>
    <title>Import contents from RSS feeds</title>
</head>

<body>
<div class="container">

    <div class="page-header">
        <h1>Import contents from RSS feeds</h1>
    </div>

    <p>${flash.message}</p>
    <ul>
        <li>
            NASA RSS: Image of the Day
            <g:link action="rssImport" params="[url: 'http://www.nasa.gov/rss/dyn/image_of_the_day.rss']" class="btn btn-default">Import</g:link>
        </li>
    </ul>

</div>

</body>
</html>