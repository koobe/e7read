<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
<title><g:message code="default.create.label" args="[entityName]" /></title>

<asset:stylesheet src="create.css"/>
<asset:stylesheet src="category_sidemenu.css"/>

<asset:javascript src="content_create.js"/>
<asset:javascript src="jquery.form.min.js"/>
<asset:javascript src="category_menu.js"/>

<sec:ifLoggedIn>
    <meta name="url2redirect" content="${createLink(controller: 'content', action: 'personal')}">
</sec:ifLoggedIn>
<sec:ifNotLoggedIn>
    <meta name="url2redirect" content="${createLink(controller: 'content', action: 'shorten')}">
</sec:ifNotLoggedIn>
<style type="text/css">
.location-link {
    color: #888888;
}
.location-link:hover {
    color: #000000;
}
</style>
</head>
<body>
<div class="main-container" onclick="hideCategoryMenu();" style="text-align: center;">
    <div style="text-align: center;">
        <div class="content-editing-title">
            <span class="anonymous-tag text-uppercase">${params.channel}</span>
            &nbsp;
            <div style="display:table-cell; background-color: #89E2D5; height: 30px; padding: 0px 20px 0px 10px;">
                <span class="title-text"><g:message code="content.create.title" /></span>
            </div>
            <img src="/assets/arrow_30.png" class="">
            <sec:ifNotLoggedIn>
                <span class="anonymous-tag">匿名模式</span>
            </sec:ifNotLoggedIn>
        </div>
    </div>
    <!--
    <div id="content-editing-textarea" class="content-editing-textarea form-control" placeholder="Write something here..." contenteditable="true"></div>
     -->

    <g:textArea id="content-editing-textarea" class="content-editing-textarea form-control" name="text" placeholder="Write something here..." rows="15"></g:textArea>

    <g:render template="editing_tips" />

    <div id="PictureContainer" class="content-editing-picture">
        <div class="picture-cell">
            <div class="picture-add" >
                <span class="fa fa-plus" style="font-size:large;"></span>
            </div>
        </div>
    </div>

    <div class="content-editing-category">
        <div class="category-cell">
            <div class="category-add">
                <span class="fa fa-bookmark" style="font-size:large;"></span>
                類別
            </div>
        </div>
    </div>

    <%--
    <div>
        <g:textField name="references" value="" placeholder="http://" class="form-control" />
    </div>
    --%>

    <div class="button-block">
        <div style="width: 60%">

            <input type="text" name="lat" value="${lat}" />
            <input type="text" name="lon" value="${lon}" />
            <input type="text" name="geolocation" value="${lat},${lon}" />


            <g:link controller="map" action="prompt" class="location-link" target="_blank">
                <i class="fa fa-map-marker"></i>
                ${location?:'地點未設定'}
            </g:link>
        </div>
        <div style="width: 10%" class="btn-item">
            <g:link class="koobe-text-btn koobe-text-btn-inverse" uri="javascript:cancelPost();" ><g:message code="default.button.cancel.label" /></g:link>
        </div>
        <div style="width: 30%" class="btn-item">
            <g:link id="button-post" class="koobe-text-btn koobe-text-btn-default" uri="javascript: postContent();"><g:message code="default.button.post.label" /></g:link>
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

<g:include controller="category" action="addCategoryPanel" params="[btnaction: 'create', channel: params.channel]" />

<script type="application/javascript">
$(function() {
    $('input[name=geolocation]').change(function() {
        var geolocation = $(this).val();
        $.geoupdate({lat: $('input[name=lat]').val(), lon: $('input[name=lon]').val()});
    });
});
</script>
</body>
</html>