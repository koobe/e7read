<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<asset:stylesheet src="create.css"/>
		<asset:javascript src="content_create.js"/>
		<asset:javascript src="jquery.form.min.js"/>
        <sec:ifLoggedIn>
            <meta name="url2redirect" content="${createLink(controller: 'content', action: 'personal')}">
        </sec:ifLoggedIn>
        <sec:ifNotLoggedIn>
            <meta name="url2redirect" content="${createLink(controller: 'content', action: 'shorten')}">
        </sec:ifNotLoggedIn>
	</head>
	<body>
        <div class="main-container">
        	<div class="content-editing-title">
				編輯內容 Post Content
                <sec:ifNotLoggedIn><span class="label label-warning">匿名模式</span></sec:ifNotLoggedIn>
            </div>
        	<!-- 
        	<div id="content-editing-textarea" class="content-editing-textarea form-control" placeholder="Write something here..." contenteditable="true"></div>
        	 -->
        	
        	<g:textArea id="content-editing-textarea" class="content-editing-textarea form-control" name="text" placeholder="Write something here..." rows="15"></g:textArea>

        	<div id="PictureContainer" class="content-editing-picture">
        		<div class="picture-cell">
        			<div class="picture-add" ><span class="fa fa-plus" style="font-size:large;"></span></div>
        		</div>
        	</div>
        	
        	<div class="content-editing-category">
        		<div class="category-cell">
        			<div class="category-add" >
	        			<span class="fa fa-plus" style="font-size:large;"></span>
	        			內容類別
        			</div>
        		</div>
        	</div>

            <!--
            <div>
                <g:textField name="references" value="" placeholder="http://" class="form-control" />
            </div>
            -->

        	<div class="button-block">
        		<div style="width: 60%">
        		</div>
        		<div style="width: 10%">
					<g:link class="koobe-text-btn koobe-text-btn-inverse" uri="javascript:cancelPost();" >取消 Cancel</g:link>
        		</div>
        		<div style="width: 30%">
					<g:link id="button-post" class="koobe-text-btn koobe-text-btn-default" uri="javascript: postContent();">發佈 Post</g:link>
	        	</div>
            </div>
            
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${contentInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${contentInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
        </div>
        <br />
        <br />

        <g:uploadForm class="uploadImageForm" name="uploadImageForm" action="uploadImage" style="display: none;">
            <input id="uploadImageInput" type="file" accept="image/*" name="file" />
        </g:uploadForm>

        <g:render template="/home/footer" />
	</body>
</html>