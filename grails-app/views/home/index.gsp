<html>
	<head>
	    <meta name="layout" content="main"/>
	    <title></title>
	</head>
	<body>
		<div id="display-container" onclick="hideCategoryMenu()"><div class="content-pane">
			<g:render template="header" model="[showcategorymenu: true]" />
			<g:render template="/content/contents_container" />
			<g:render template="footer" />
        </div></div>
		
		<g:include controller="category" action="addCategoryPanel" params="[btnaction: 'home']" />
		
		<a href="javascript: scrollDisplayContainerToTop();" class="koobe-btn koobe-btn-normal top-btn-pos">
			<i class="fa fa-caret-up"></i>
		</a>
	</body>
</html>