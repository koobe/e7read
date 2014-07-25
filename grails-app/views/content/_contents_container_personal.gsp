<asset:stylesheet src="content_personal.scss"/>
<asset:javascript src="content_personal.js"/>
<div id="contents_container" class="container-fluid maincontainer">
	<g:include controller="content" action="renderPersonalContentsHTML" params="[max:4, offset:0]" />
</div>
<script type="text/javascript">
	addHandlers();
</script>
