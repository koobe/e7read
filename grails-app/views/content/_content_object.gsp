<div class="media hovercontent ">
	<div class="col-sm-5 col-xs-5 ">
		<a class="pull-left col-xs-12" href="#">
			<g:img class="media-object img-responsive img-rounded" uri="${it.coverUrl}" alt="cover" />
		</a>
	</div>
	<div class="col-sm-7 col-xs-7 media-body ">
		<a href="#">
			<h4 class="media-heading text-uppercase">${it.cropTitle}</h4>
		</a>
		<h6><g:formatDate date="${it.dateCreated}" type="datetime" style="LONG" timeStyle="SHORT"/></h6>
		<h6>Author: ${it.user.fullName}</h6>
		<p class="text-left">${it.cropText}</p>
	</div>
</div>