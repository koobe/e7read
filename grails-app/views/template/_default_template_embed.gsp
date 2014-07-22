
<div style="width:100%; height:100%;">
	<div style=" display: table; border-spacing: 5px;width:100%; height:50%;">
		<div style="display: table-row; border: 1px solid red;">
			<g:each in="${it.pictureSegments}" var="segment">
				<div style="display: table-cell; height:100%; border-radius: 5px; border: 1px solid #ccc; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${segment.originalUrl});"></div>
			</g:each>
		</div>
	</div>
	<div>
		<div style="padding:5px;">
			<g:each in="${it.textSegments}" var="segment">
				<p style="text-align:justify;">${segment.text}</p>
			</g:each>
		</div>
	</div>
</div>