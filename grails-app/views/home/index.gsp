<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    <asset:javascript src="content_show.js"/>
	    <asset:stylesheet src="content_viewer_menu.css"/>
	</head>
	<body>
		<div id="display-container">
			<g:render template="header" />
			<g:render template="/content/contents_container" />
			<g:render template="footer" />
		</div>
		<g:link uri="#" class="koobe-btn koobe-btn-normal top-btn-pos">
			<i class="fa fa-caret-up"></i> <!-- My Contents  -->
		</g:link>
	</body>
</html>