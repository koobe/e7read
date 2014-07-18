<div class="col-sm-5 col-xs-5">
	<g:img class="pull-left img-responsive img-rounded image-shadow" uri="${it.coverUrl}" />
</div>
<div class="content-element col-sm-7 col-xs-7">

    <div class="content-element-header">
        <h3 class="element-title editing-title" contenteditable="true" contentid="${it.id}">
            ${it.cropTitle}
        </h3>

        <p class="element-date last-updated">
            <strong>Last Updated:</strong>
            <g:formatDate date="${it.lastUpdated}" type="datetime" style="LONG" timeStyle="SHORT"/>
        </p>
        <p class="element-date date-created">
            <strong>Date Created:</strong>
            <g:formatDate date="${it.dateCreated}" type="datetime" style="LONG" timeStyle="SHORT"/>
        </p>
    </div>

    <div class="content-element-body">
        <p class="element-text text-left" contenteditable="true">${it.cropText}</p>
    </div>
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