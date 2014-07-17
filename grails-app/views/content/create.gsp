<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<asset:stylesheet src="content_create.css"/>
		<asset:javascript src="content_create.js"/>
		<asset:javascript src="jquery.form.min.js"/>
	</head>
	<body>
        <div class="">
        	<div class="content-editing-title">Post Content</div>
        	<div id="content-editing-textarea" class="content-editing-textarea form-control" placeholder="Write something here..." contenteditable="true"></div>
        	
        	<g:uploadForm class="uploadImageForm" name="uploadImageForm" action="uploadImage" style="display: none;">
        		<input id="uploadImageInput" type="file" accept="image/*" name="file" />
        	</g:uploadForm>
        	
        	<div id="PictureContainer" class="content-editing-picture">
        		<div class="picture-cell">
        			<div class="picture-add" ><span class="fa fa-file-image-o" style="font-size:large;"></span></div>
        		</div>
        		<!-- <div class="text-uppercase" style="display: table-row;">TIP: Delete uploaded image by touch.</div>  -->
        	</div>
        	
        	<div class="button-block">
        		<g:link class="btn btn-default button-ele" uri="javascript:cancelPost();" >Cancel</g:link>
	        	<g:link id="button-post" class="btn btn-primary btn-block button-ele" uri="javascript: postContent();">Post</g:link>
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
	</body>
</html>