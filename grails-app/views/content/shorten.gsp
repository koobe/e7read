<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title></title>
</head>

<body>
<div class="container">

    <div class="page-header">
        <h2>Congratulation! Your post has been published.</h2>
    </div>

    <p>Content code is:</p>
    <p>${hashcode}</p>

    <p>If you need to re-edit this content in the future, please use the following url:</p>
    <p><g:link controller="content" action="modify" params="[hash: hashcode]">${createLink(controller: 'content', action: 'modify', params: [hash: hashcode], absolute: true)}</g:link></p>

    <br/><br/>

    <g:link uri="/#content-${contentId}" class="btn btn-default">View Content</g:link>
</div>
</body>
</html>