<div class="media hovercontent" contentid="${it.id}">
	<div class="col-sm-5 col-xs-5">
		<g:img class="pull-left img-responsive img-rounded" uri="${it.coverUrl}" />
	</div>
	<div class="col-sm-7 col-xs-7">
		<h4 contenteditable="true">${it.cropTitle}</h4>
		<h6><g:formatDate date="${it.dateCreated}" type="datetime" style="LONG" timeStyle="SHORT"/></h6>
		<p class="text-left">${it.cropText}</p>
	</div>
</div>