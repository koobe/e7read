<div style="width:100%; height:100%;">
	<div style=" display: table; border-spacing: 10px;width:100%; height:50%;">
		<div style="display: table-row;">
			<g:each in="${it.pictureSegments}" var="segment">
				<div style="box-shadow: 0 1px 2px 1px #ccc; display: table-cell; height:100%; border-radius: 10px; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${segment.originalUrl});"></div>
			</g:each>
		</div>
	</div>
	<div style="padding:7px;">
			<h2>${it.cropTitle}</h2>
		</div>
	<div>
		<div style="padding:5px;">
			<g:each in="${it.textSegments}" var="segment">
				<p style="text-align:justify;">${segment.text}</p>
			</g:each>
		</div>
	</div>
</div>