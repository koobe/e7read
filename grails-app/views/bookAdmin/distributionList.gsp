<html>
	<head>
	    <meta name="layout" content="main"/>
	    
	    <script type="text/javascript">
	    	$(function() {
	    		$('.book-delivery').addClass('active');
			});
	    </script>
	    
	    <asset:javascript src="bookAdmin/search.js"/>
	</head>
	<body>
		<g:render template="/bookAdmin/header" />
		
		<g:render template="contentlist_table"></g:render>
		
		<div style="text-align: center;">
			<g:paginate next="&raquo;" prev="&laquo;" total="${contentCount}" params="${params}" />
		</div>
		
		<g:render template="/home/footer" />
	</body>
</html>