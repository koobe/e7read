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
	@media screen and (min-width: 768px) {
		.contents-container {
			padding-top: 15px;
			margin-left: 30px;
			margin-right: 30px;
		}
	}
	@media screen and (max-width: 767px) {
		.contents-container {
			padding-top: 15px;
			margin-left: 10px;
			margin-right: 15px;
		}
	}
</style>
<asset:javascript src="content_container.js"/>
<div id="contents_container" class="container-fluid contents-container">
</div>