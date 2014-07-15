<div class="col-sm-5 col-xs-5">
	<g:img class="pull-left img-responsive img-rounded image-shadow" uri="${it.coverUrl}" />
</div>
<div class="col-sm-7 col-xs-7">
	<h4 class="editing-title" contenteditable="true" contentid="${it.id}">${it.cropTitle}</h4>
	<h6 class="last-updated">Last Updated: <g:formatDate date="${it.lastUpdated}" type="datetime" style="LONG" timeStyle="SHORT"/></h6>
	<h6>Date Created: <g:formatDate date="${it.dateCreated}" type="datetime" style="LONG" timeStyle="SHORT"/></h6>
	<p class="text-left">${it.cropText}</p>
</div>
<div class="item-editing-menu">
	<!-- <span class="text-uppercase">TIP: Click title for editing.</span>  -->
	<div class="editing-buttons">
		<g:render template="content_editing_buttons" bean="${it}"/>
	</div>
</div>
<g:if test="${it.isPrivate}">
   	<div class="private-div">
   		<h5>PRIVATE</h5>
   	</div>
</g:if>