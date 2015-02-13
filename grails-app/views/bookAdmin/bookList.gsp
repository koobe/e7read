<html>
	<head>
	    <meta name="layout" content="main"/>
	    
	    <script type="text/javascript">
	    	$(function() {
	    		$('.book-list').addClass('active');
			});
	    </script>
	</head>
	<body>
		<g:render template="/bookAdmin/header" />
		
		<g:render template="/bookAdmin/booklist_table" />
		
		<div style="text-align: center;">
			<g:paginate next="&raquo;" prev="&laquo;" total="${bookCount}" params="${params}" />
		</div>
		
		<g:render template="/home/footer" />
	</body>
</html>