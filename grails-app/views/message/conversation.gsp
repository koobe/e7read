<html>
	<head>
	    <meta name="layout" content="main"/>
	    
	    <meta name="params-max" content="${max}"/>
	    <meta name="params-totalSize" content="${totalSize}"/>
	    <meta name="params-messageBoardId" content="${messageBoardId}"/>
	    
	    <asset:stylesheet src="loadingspinner.css"/>
	    <asset:javascript src="jquery.loadingspinner.js"/>
	    
	    <asset:stylesheet src="message/conversation.css"/>
	    <asset:javascript src="message/conversation.js"/>
	</head>
	<body id="mybody">
			<nav>
				<div class="layout-table" style="padding: 10px 0px 15px 0px;">
					<div class="layout-table-cell" style="background-color: #89E2D5; 
							height: 30px; font-size:1.4em; color: white; font-weight: 700;
							padding: 0px 70px 0px 50px; vertical-align:middle;">
						<i class="fa fa-envelope"></i>
						<span>訊息</span>
					</div>
					<div class="layout-table-cell" style="vertical-align:middle;">
						<img src="/assets/arrow_30.png">
					</div>
				</div>	
			</nav>
		
			<div class="message-content-container">
				<div class="message-content">
					<div class="message-content-btn-loadmore" style="text-align:center; display: none;">
						<button type="button" class="btn btn-default" style="
						font-size: 0.7em; 
						line-height: 0.7em;
						padding: 5px 40px 5px 40px;">Show Previous Message</button>
					</div>
					<div class="message-content-anchor"></div>
					<div class="message-content-anchor-last"></div>
				</div>
			</div>
			
			<footer>
				<g:render template="message_box_send_panel"></g:render>
			</footer>
	</body>
</html>