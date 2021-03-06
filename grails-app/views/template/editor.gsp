<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Template Editor</title>

    <%-- <g:set var="codeMirrorUrl" value="//cdnjs.cloudflare.com/ajax/libs/codemirror/4.3.0" /> --%>
    <g:set var="codeMirrorUrl" value="//cdn.jsdelivr.net/codemirror/4.3.0"/>

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
        min-height: 100%;
        padding-top: 50px;
        /* padding-bottom: 50px; */
    }

    .CodeMirror-scroll {
        width: 100%;
        height: auto;

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

        height: 50px;

        background-color: white;

        box-shadow: 0 0 5px darkgray;
        border-bottom: 1px solid darkgray;
    }
    </style>
</head>

<body>

<div class="top-panel">
    <form class="form-inline">
        <i class="fa fa-file-o"></i>
        <select name="template.id" class="form-control">
            <option value=""></option>
            <g:each in="${templates}">
                <g:if test="${template?.id == it.id}">
                    <option value="${it.id}" data-href="${createLink(action:'editor', id:it.id)}" selected>${it.grouping} - ${it.name}</option>
                </g:if>
                <g:else>
                    <option value="${it.id}" data-href="${createLink(action:'editor', id:it.id)}">${it.grouping} - ${it.name}</option>
                </g:else>
            </g:each>
        </select>
        <g:if test="${template}">
            <button class="button-save form-control">
                <i class="fa fa-save"></i>
                Save
            </button>
        </g:if>
        <div class="pull-right">
            <g:link action="reloadAllDefaultTemplates" class="btn btn-default"
                    onclick="return confirm('Are you sure to reload all templates from disk?')">
                <i class="fa fa-rotate-left"></i>
                Reload All
            </g:link>
        </div>
    </form>
</div>

<g:if test="${template}">
    <g:form action="editorSave" id="${template.id}" class="form-editor form-inline" method="post">
        <g:textArea name="html" class="form-control" value="${template.html}"/>
    </g:form>
</g:if>


<script type="text/javascript">
    $(function () {

        if ($('textarea[name=html]').length > 0) {
            var myCodeMirror = CodeMirror.fromTextArea(document.getElementById('html'), {
                lineNumbers: true,
                mode: "htmlmixed",
                smartIndent: false,
                theme: 'ambiance'
            });
        }

        $('select[name="template.id"]').change(function () {

            if ($(this).val()) {
                location.href = $('option:selected', this).data('href');
            }
            else {
                location.href = "${createLink(action: 'editor')}";
            }
        });

        $('button.button-save').click(function() {
            $('form.form-editor').submit();
            return false;
        });
    });
</script>

</body>
</html>
