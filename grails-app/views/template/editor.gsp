<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<title>Template Editor</title>

<%-- <g:set var="codeMirrorUrl" value="//cdnjs.cloudflare.com/ajax/libs/codemirror/4.3.0" /> --%>
<g:set var="codeMirrorUrl" value="//cdn.jsdelivr.net/codemirror/4.3.0" />

<link rel="stylesheet" href="${codeMirrorUrl}/codemirror.css">
<link rel="stylesheet" href="${codeMirrorUrl}/theme/ambiance.css">

    <script src="${codeMirrorUrl}/codemirror.js"></script>
    <script src="${codeMirrorUrl}/mode/xml/xml.js"></script>
    <script src="${codeMirrorUrl}/mode/javascript/javascript.js"></script>
    <script src="${codeMirrorUrl}/mode/css/css.js"></script>
    <script src="${codeMirrorUrl}/mode/htmlmixed/htmlmixed.js"></script>

<style type="text/css">
    html, body {
        width: 100%;
        height: 100%;
    }
    .CodeMirror {
        line-height: 1.5em;
        border: 1px solid #eee;
        width: 100%;
        height: auto;
        padding-top: 50px;
    }
    .CodeMirror-scroll {
        overflow-y: hidden;
        overflow-x: auto;
    }
    .top-panel {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;

        z-index: 999;
        padding: 5px 10px;

        background-color: white;

        box-shadow: 0 0 5px darkgray;
        border-bottom: 1px solid darkgray;
    }
</style>
</head>
<body>

<div class="top-panel">
    <g:form action="editor" class="templateSelectForm form-inline" method="post">
        Open:
        <g:select name="id" from="${templates}" value="${template?.id}" optionKey="id" optionValue="name" class="form-control" onchange="\$('.templateSelectForm').submit()" noSelection="['':'']" />

        <g:if test="${template}">
            <g:submitButton name="save" class="form-control" />
        </g:if>

        <div class="pull-right">
            <g:link action="reloadAllDefaultTemplates" class="btn btn-default" onclick="return confirm('Are you sure to reload all templates from disk?')">Reload All</g:link>
        </div>
    </g:form>
</div>

<g:if test="${template}">
    <g:textArea name="html" class="form-control" value="${template?.html}" />

    <script type="text/javascript">
        $(function() {
            var myCodeMirror = CodeMirror.fromTextArea(document.getElementById('html'), {
                lineNumbers: true,
                mode: "htmlmixed",
                smartIndent: false,
                theme: 'ambiance'
            });
        });
    </script>
</g:if>

</body>
</html>
