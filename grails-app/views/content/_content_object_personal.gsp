<div class="media hovercontent col-sm-6" contentid="${it.id}">
	<div class="col-sm-5 col-xs-5">
		<g:img class="pull-left img-responsive img-rounded" uri="${it.coverUrl}" />
	</div>
	<div class="col-sm-7 col-xs-7">
		<h4 class="editing-title" contenteditable="true" contentid="${it.id}">${it.cropTitle}</h4>
		<h6><g:formatDate date="${it.dateCreated}" type="datetime" style="LONG" timeStyle="SHORT"/></h6>
		<p class="text-left">${it.cropText}</p>
	</div>
	<div class="item-editing-menu">
		<span class="text-uppercase">TIP: Click title for editing.</span>
		<div>
			<g:link class="btn btn-primary button" uri="javascript: void(0)">Edit</g:link>
			<g:link class="btn btn-primary button" uri="javascript: deleteContent('${it.id}');">Delete</g:link>
			<g:link class="btn btn-primary button" uri="javascript: void(0)">Make Private</g:link>
		</div>
	</div>
</div>