<html>
	<head>
	    <meta name="layout" content="main"/>
	    
	    <meta name="params-max" content="${max}"/>
	    <meta name="params-totalSize" content="${totalSize}"/>
	    
	    <asset:javascript src="message/index.js"/>
	    <asset:stylesheet src="message/messageboard_table.css"/>
	</head>
	<body id="mybody">
		<div class="container">
		
			<div style="text-align:center; color: #333; font-size: 1.3em; font-weight: 700; padding: 10px 0px 20px 0px;">
				E7MESSAGE
			</div>
		
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