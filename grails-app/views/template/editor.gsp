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
        .CodeMirror {
            line-height: 1.5em;
        }
        .CodeMirror {
            border: 1px solid #eee;
            height: auto;
        }
        .CodeMirror-scroll {
            overflow-y: hidden;
            overflow-x: auto;
        }
    </style>
</head>
<body>

<div class="container">
    <g:form action="editor" class="templateSelectForm" method="get">
        <g:select name="id" from="${kgl.OriginalTemplate.list()}" value="${template?.id}" optionKey="id" optionValue="name" class="form-control" onchange="\$('.templateSelectForm').submit()" />
    </g:form>

    <g:if test="${template}">
        <g:form action="editor" method="post" id="${template?.id}">
            <g:textArea name="html" class="form-control" value="${template?.html}" />
            <g:submitButton name="save" class="btn btn-default btn-block" />
        </g:form>
        <script type="text/javascript">
            $(function() {
                var myCodeMirror = CodeMirror.fromTextArea(document.getElementById('html'), {
                    lineNumbers: true,
                    mode: "htmlmixed"
                });
            });
        </script>
    </g:if>
</div>


</body>
</html>
