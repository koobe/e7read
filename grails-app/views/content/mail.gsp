<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Send by E-Mail</title>
    <style type="text/css">
    </style>
</head>
<body>

<div class="container">

    <div class="page-header">
        <h3>Share by E-Mail</h3>
    </div>

    <div class="form-group">
        <label>收件人</label>
        <g:textField name="to" value="" class="form-control" />
    </div>

    <div class="form-group">
        <label>主旨</label>
        <g:textField name="subject" value="Fwd: ${contentInstance.cropTitle}" class="form-control" />
    </div>

    <div class="form-group">
        <label>內容</label>
        <g:textArea name="message" value="${contentInstance.cropText}\n\nRead full article from E7READ.\n${createLink(controller: 'content', action: 'share', id: contentInstance.id, absolute: true)}" class="form-control" style="height:300px"/>
    </div>

    <button class="btn btn-primary"><g:message code="default.button.submit.label" /></button>
    <button class="btn btn-default"><g:message code="default.button.close.label" /></button>
</div>

<script type="application/javascript">

</script>
</body>
</html>