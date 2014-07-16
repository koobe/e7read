<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>
<p>${flash.message}</p>
<ul>
    <li><g:link action="rssImport" params="[url: 'http://www.nasa.gov/rss/dyn/image_of_the_day.rss']">NASA RSS: Image of the Day</g:link></li>
</ul>
</body>
</html>