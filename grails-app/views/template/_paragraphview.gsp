<div data-role="page" id="page${pageId}" class="paragraphview">
	<div role="main" class="ui-content">
		<div class="template-container">
			<g:each in="${segments}" var="segment">
	            <markdown:renderHtml>${segment.text}</markdown:renderHtml>
	        </g:each>
        </div>
	</div>
</div>