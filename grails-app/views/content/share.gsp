<%@ page import="kgl.Content" %>
<!DOCTYPE html>
<html prefix="og: http://ogp.me/ns#">
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'content.label', default: 'Content')}" />
    <g:set var="staticUrl" value="${createLink(controller: 'content', action: 'share', id: contentInstance.id, absolute: true)}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>

    <!-- Open Graph Metadata -->
    <meta property="og:title" content="${contentInstance.cropTitle}" />
    <meta property="og:description" content="${contentInstance.cropText}" />
    <meta property="og:type" content="article" />
    <meta property="og:url" content="${staticUrl}" />
    <meta property="og:image" content="${contentInstance.coverUrl}" />

    <style type="text/css">
        @import url(http://fonts.googleapis.com/earlyaccess/cwtexhei.css);

        div.maximized { position:fixed; top:0; left:0; width:100%; height:100%; }
        div.maximized iframe { width:100%; height:100%; border:0 none; padding-top: 50px }
        div.topPanel {
            background-color: #e8e8e8;
            position: fixed; top: 0; left: 0; right: 0; padding: 5px 0 5px 5px;
            border-bottom: 1px solid #000000;
            box-shadow: 0px 1px 3px darkgray;
        }
        div.topPanel h1 {
            display: inline-block;
            font-weight: normal;
            font-size: 14px;
            padding: 0 20px 0 20px;
            margin: 0;
            color: #00003e;
            text-shadow: 1px 1px 1px darkgray;
            font-family: 'cwTeXHei', sans-serif;
        }
        div.fb-share-button {
            display: inline-block;
        }
    </style>
</head>
<body>

<fb:init/>

<div class="maximized">
    <g:if test="${template}">
        <iframe class="iframe-embed" src="${createLink(controller: 'content', action: 'embed', id: contentInstance.id, params: ['template.id': template?.id])}" width="100%" height="800px" frameborder="0" ></iframe>
    </g:if>
    <g:else>
        <iframe class="iframe-embed" src="${createLink(controller: 'content', action: 'embed', id: contentInstance.id)}" width="100%" height="800px" frameborder="0" ></iframe>
    </g:else>
</div>

<div class="topPanel">
    <!--${contentInstance}-->
    <g:form action="edit" id="${contentInstance.id}" class="form-inline" role="form" method="get">
        <h1>
            <i class="fa fa-facebook-square"></i>
            ${contentInstance.cropTitle}
        </h1>

        <div class="visible-md-inline visible-lg-inline visible-sm-inline pull-right" style="margin-right: 20px">

            <g:each in="${contentInstance.categories}">
                <span class="label label-primary">${it.name}</span>
            </g:each>

            <fb:share href="${staticUrl}" />

            <!--buttons-->
            <g:link uri="/" class="btn btn-default btn-sm">E7READ</g:link>
        </div>

    </g:form>
</div>

<script type="text/javascript">
$(function() {
    $('.iframe-embed').size();
});
</script>

</body>
</html>
