<asset:stylesheet src="content_personal.css"/>
<asset:javascript src="content_personal.js"/>
<div id="contents_container" class="container-fluid maincontainer">
	<g:include controller="content" action="renderPersonalContentsHTML" params="[max:4, offset:0]" />
	<script type="text/javascript">
		addHandlers();
	</script>
	<!-- <div id="testdiv"></div> -->
</div>