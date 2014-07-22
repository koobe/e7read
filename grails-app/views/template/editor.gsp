<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<title>Template Editor</title>

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/codemirror/4.3.0/codemirror.css">

<script src="//cdnjs.cloudflare.com/ajax/libs/codemirror/4.3.0/codemirror.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/codemirror/4.3.0/mode/xml/xml.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/codemirror/4.3.0/mode/javascript/javascript.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/codemirror/4.3.0/mode/css/css.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/codemirror/4.3.0/mode/htmlmixed/htmlmixed.js"></script>

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
        <g:select name="id" from="${kgl.OriginalTemplate.list()}" value="${template?.id}" optionKey="id" optionValue="name" class="form-control" onchange="\$('.templateSelectForm').submit()" />

        <g:if test="${template}">
            <g:submitButton name="save" class="form-control" />
        </g:if>
    </g:form>
</div>


<g:if test="${template}">
    <g:textArea name="html" class="form-control" value="${template?.html}" />

    <script type="text/javascript">
        $(function() {
            var myCodeMirror = CodeMirror.fromTextArea(document.getElementById('html'), {
                lineNumbers: true,
                mode: "htmlmixed",
                smartIndent: false
            });
        });
    </script>
</g:if>

</body>
</html>
