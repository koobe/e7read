<div class="container-fluid" style="display: table; border-spacing: 5px;">
	<div style="display: table-row;">
		<g:each in="${pictureSegments}">
			<div style="display: table-cell; width:33%;">
				<g:img uri="${it.originalUrl}" class="img-responsive img-rounded"  />
			</div>
		</g:each>
	</div>
</div>
<div class="container-fluid">
	<div style="padding:5px;">
		<g:each in="${textSegments}">
			<p class="text-segment" style="text-align:justify;">${it.text}</p>
		</g:each>
	</div>
</div>