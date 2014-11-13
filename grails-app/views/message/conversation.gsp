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
				<g:render template="/home/section_title" model="[sectionTitle: '訊息', fontAwesome:'fa-envelope']"></g:render>
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