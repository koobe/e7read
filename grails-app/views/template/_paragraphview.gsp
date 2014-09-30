<div data-role="page" id="pageid-${pageId}" class="paragraphview">
	<div data-role="header">
	</div>
	<div role="main" class="ui-content">
		<g:each in="${segments}" var="segment">
            <markdown:renderHtml>${segment.text}</markdown:renderHtml>
        </g:each>
	</div>
	<div data-role="footer">
	</div>
</div>