<div id="content-${it.id}" class="content-element">
    <g:if test="${it.hasPicture}">
        <div class="content-element-image col-sm-5">
            <g:img class="img-responsive img-rounded image-shadow" uri="${it.coverUrl}" />
        </div>
        <div class="col-sm-7">
    </g:if>
            <div class="content-element-header">
                <h3 class="element-title editing-title inline-editing-auto-save" contenteditable="true" contentid="${it.id}" data-id="${it.id}" data-field="cropTitle" data-url="${createLink(action: 'ajaxInlineUpdate')}">
                    ${it.cropTitle}
                </h3>
                <p class="element-date last-updated">
                    <strong>Last Updated:</strong>
                    <span class="date-value"><g:formatDate date="${it.lastUpdated}" type="datetime" style="LONG" timeStyle="SHORT"/></span>
                </p>
                <!--
                <p class="element-date date-created">
                    <strong>Date Created:</strong>
                    <g:formatDate date="${it.dateCreated}" type="datetime" style="LONG" timeStyle="SHORT"/>
                </p>
                -->
            </div>
            <div class="content-element-body">
                <p class="element-text text-left" contenteditable="true" data-id="${it.id}" data-field="cropText" data-url="${createLink(action: 'ajaxInlineUpdate')}">${it.cropText}</p>
            </div>
    <g:if test="${it.hasPicture}">
        </div>
    </g:if>
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