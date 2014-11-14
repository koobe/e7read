<html>
	<head>
	    <meta name="layout" content="main"/>
	    
	    <meta name="params-max" content="${max}"/>
	    <meta name="params-totalSize" content="${totalSize}"/>
	    
	    <asset:javascript src="message/index.js"/>
	    <asset:stylesheet src="message/messageboard_table.css"/>
	    
	    <style type="text/css">
	    	body {
	    		background-color: #FAF8F5;
	    	}
	    </style>
	</head>
	<body id="mybody">
		<g:render template="/home/header" model="[showcategorymenu: false, showsearchbar: false]" />
	
		<div class="container">
			<g:render template="/home/section_title" model="[sectionTitle: '訊息', fontAwesome:'fa-envelope']"></g:render>
		
			<div id="messageboard-table">
				<g:render template="messageboard_table"></g:render>
			</div>
			
			<div>
				<ul class="pager">
					<li class="previous" style="cursor:pointer;"><a>&larr; Newer</a></li>
					<li class="next" style="cursor:pointer;"><a>Older &rarr;</a></li>
				</ul>
			</div>
		</div>
	</body>
</html>