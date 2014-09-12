<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title></title>
    <asset:javascript src="jquery.fullframe.js" />
</head>

<body>

	<div id="display-container">
		<g:render template="/home/header" model="[showcategorymenu: true]" />
	</div>
	
	<div class="container" style="padding-top: 40px;">
	    <div style="text-align: center;" class="alert alert-success">
	    		<span>Congratulation! Your post has been published.</span>
	    </div>
	</div>

<div class="container">
    <p>Content code is:</p>
    <p><code style="font-size:200%;">${hashcode}</code></p>

    <p>If you need to re-edit this content in the future, please use the following url:</p>
    <p><g:link controller="content" action="modifyByHash" params="[hash: hashcode]">${createLink(controller: 'content', action: 'modifyByHash', params: [hash: hashcode], absolute: true)}</g:link></p>

    <div class="row">
        <div class="col-xs-6">
            <input class="form-control friendly-url" type="text" value="${createLink(controller: 'content', action: 'modifyByHash', params: [hash: hashcode], absolute: true)}" readonly style="cursor: pointer" />
        </div>
        <div class="col-xs-6">
            <button class="btn btn-default friendly-url-copy" style="display: none">Copy to clipboard</button>
        </div>
    </div>

    <br/><br/>

    <g:link uri="/share/${contentId}" class="btn btn-default">View Content</g:link>
</div>

<g:render template="/home/footer" />
		
<g:include controller="category" action="addCategoryPanel" params="[btnaction: 'home']" />

<script type="text/javascript">
    $(function() {
        $('.friendly-url').click(function() {
            $(this).select();
        });
        $('.friendly-url-copy').click(function() {
        });
    });

   function viewContent(url) {
	   var fullframe = $.fullframe({iframeUrl: url});
	   fullframe.openFrame();
   }
</script>
</body>
</html>