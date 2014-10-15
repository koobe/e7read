<div class="image-gallery">
    <div class="image-gallery-table">
        <g:each in="${content.pictureSegments}" var="picture">
        	<div class="image-table-cell">
	            <div class="div-bg-thumbnail-cover"
					style="border: 5px solid #fff; width:98%; height: 100%; background-image:url(${picture.thumbnailUrl? picture.thumbnailUrl: picture.originalUrl});" 
					data-imageurl="${picture.originalUrl}">
				</div>
			</div>
        </g:each>
    </div>
</div>