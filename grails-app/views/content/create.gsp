<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
        <div class="container" role="main">
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
            <g:uploadForm role="form" url="[resource:contentInstance, action:'save']" >
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-12">
                            <textarea class="form-control" name="fullText" rows="15" placeholder="請輸入文字內容...">${contentInstance.cropText}</textarea>
                        </div>
                    </div>
                </div>
                <div class="form-group text-right">
                    <div class="row">
                        <div class="col-xs-12">
                            <div style="padding: 50px 0; text-align: center; background: #dadada; border-radius: 5px">
                                <b>上傳圖片</b>
                                <br/>
                                <br/>
                                <input type="file" accept="image/*" name="imageFiles" capture="camera" multiple style="display: inline-block" />
                            </div>
                            <!--<input class="form-control" name="coverUrl" placeholder="圖片網址..." value="${contentInstance.coverUrl}" />-->
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-6">
                            <g:submitButton name="create" class="btn btn-primary btn-block save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                        </div>
                        <div class="col-xs-6">
                            <g:link uri="javascript:history.back()" class="btn btn-default btn-block ">Cancel</g:link>
                        </div>
                    </div>
                </div>
            </g:uploadForm>
        </div>
	</body>
</html>
