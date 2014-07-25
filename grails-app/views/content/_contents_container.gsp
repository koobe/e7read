<style>
	.hovercontent {
		padding: 5px;
		border: 1px solid #fff;
	}
	.hovercontent:hover {
		padding: 5px;
		border: 1px solid #ccc;
		border-radius: 5px;
		box-shadow:2px 2px 2px 1px rgba(0,0,0,.075);
		transition: border-color ease-in-out .10s,box-shadow ease-in-out .1s;
	}
	.contents-container {
		margin-left: 15px;
		margin-right: 15px;
	}
</style>
<asset:javascript src="content_container.js"/>
<div id="contents_container" class="container-fluid contents-container">
	<g:include controller="content" action="renderContentsHTML" params="[max:5, offset:0]" />
</div>