<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	    <asset:stylesheet src="content_viewer_menu.css"/>
	    <asset:stylesheet src="content_personal.css"/>
		<asset:javascript src="content_personal.js"/>
		<asset:javascript src="content_show.js"/>
	</head>
	<body>
		<div id="display-container">
			<g:render template="/home/header" />
			<g:render template="/content/contents_container_personal" />
			<g:render template="/home/footer" />
		</div>
	</body>
</html>