<div id="content-${it.id}" class="content-element" style="display: table;">
	<div style="display: table-row;">
		<div style="display: table-cell; width: 40%; border-radius: 5px; background-position: center; background-repeat: no-repeat; background-size: cover; background-image:url(${it.coverUrl}); box-shadow: 0 1px 2px 1px #ccc;"></div>
		<div style="display: table-cell; width: 60%; padding-left: 10px;">
			<div class="content-element-header">
		        <h3 class="element-title editing-title inline-editing-auto-save" contenteditable="true" contentid="${it.id}"
		            data-id="${it.id}" data-field="cropTitle" data-url="${createLink(action: 'ajaxInlineUpdate')}">
		            ${it.cropTitle}
		        </h3>
		        <p class="element-date last-updated">
		            Last Updated:
		            <span class="date-value"><g:formatDate date="${it.lastUpdated}" type="datetime" style="LONG" timeStyle="SHORT"/></span>
		        </p>
    		</div>
			<div class="content-element-body">
		        <p class="element-text text-left" contenteditable="true" data-id="${it.id}" data-field="cropText" data-url="${createLink(action: 'ajaxInlineUpdate')}">
		            ${it.cropText}
		        </p>
		        <g:if test="${it.references}">
			        <p class="element-references" data-id="${it.id}">
			        	<span class="fa fa-link"></span>
			        	<a href="${it.references}" target="_blank">Link</a>
			        </p>
		        </g:if>
		        <g:else>
		        	<p class="element-references" data-id="${it.id}" style="display:none;">
			        	<span class="fa fa-link"></span>
			        	<a href="#" target="_blank">Link</a>
			        </p>
		        </g:else>
		        <div class="btn-group" data-toggle="buttons">
		            <a href="#" class="btn btn-default btn-xs disabled">Display vCard?</a>
		            <label class="btn btn-default btn-xs ${it.isShowContact?'active':''}">
		                <input type="radio" name="isShowContact" value="true" data-id="${it.id}" /> Show
		            </label>
		            <label class="btn btn-default btn-xs ${it.isShowContact?'':'active'}">
		                <input type="radio" name="isShowContact" value="false" data-id="${it.id}"> Hide
		            </label>
		        </div>
		    </div>
		</div>
	</div>
</div>
<g:if test="${it.isPrivate}">
    <div class="private-div">
    	<div>
        	<span class="fa fa-lock"></span>
        </div>
    </div>
</g:if>
<div class="item-editing-menu">
    <div class="editing-buttons">
        <g:render template="content_editing_buttons" bean="${it}"/>
    </div>
</div>
