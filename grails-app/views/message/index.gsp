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
		<nav>
			<div class="" style="display:table; padding: 10px 0px 15px 0px;">
				<div class="" style="display:table-cell; background-color: #89E2D5; 
						height: 30px; font-size:1.4em; color: white; font-weight: 700;
						padding: 0px 70px 0px 50px; vertical-align:middle;">
					<i class="fa fa-envelope"></i>
					<span>訊息</span>
				</div>
				<div class="" style="display:table-cell; vertical-align:middle;">
					<img src="/assets/arrow_30.png">
				</div>
			</div>	
		</nav>
	
		<div class="container">
		
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