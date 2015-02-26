<html>
	<head>
	    <meta name="layout" content="main"/>
	    
	    <style type="text/css">
	   		.edit-button {
	    		display: inline-block;
	    	}
	    </style>
	    
	    <script type="text/javascript">
	    	$(function() {
	    		$('.publisher-list').addClass('active');
			});
	    </script>
	    
	    <asset:javascript src="bookAdmin/publisher_list_table.js"/>
	</head>
	<body>
		<g:render template="/bookAdmin/header" />
		
		<div class="container-fuild" style="">
		    
		    <g:render template="/publisher/function_button" />
		    
		    <g:render template="/publisher/list_table" />
		    
		    <div style="text-align: center;">
				<g:paginate next="&raquo;" prev="&laquo;" total="${publisherCount}" params="${params}" />
			</div>
		    
		</div>
		
		<g:render template="/home/footer" />
	</body>
</html>