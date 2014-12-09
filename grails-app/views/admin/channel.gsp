<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <title>管理介面</title>
</head>

<body>

<div class="container">

    <div class="page-header">
        <div class="btn-group pull-right" role="group">
            <button type="button" id="btnChannelAdd" class="btn btn-default">
                <i class="fa fa-plus"></i>
                新增
            </button>
            <g:link controller="admin" action="dashboard" class="btn btn-default">返回</g:link>
        </div>
        <h2>頻道管理</h2>
    </div>

    <form role="form" class="well" id="formChannelAdd" style="display: none">
        <div class="form-group">
            <label for="channelName">Channel Name</label>
            <input type="text" class="form-control" id="channelName" placeholder="Enter Channel Name">
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
        <button type="submit" class="btn btn-default" id="btnFormCancel">Cancel</button>
    </form>

    <div class="list-group">
        <g:each in="${channels}" var="channel">
            <g:link controller="admin" action="coverFiles" class="list-group-item">
                <img src="${channel.iconUrl}" />
                ${channel.name}
            </g:link>
        </g:each>
    </div>
</div>

<script type="text/javascript">
$(function() {
    $('#btnChannelAdd').click(function() {
        $('#formChannelAdd').show('slow');
    });

    $('#btnFormCancel').click(function() {
        $('#formChannelAdd').hide('slow');
    });
});
</script>
</body>
</html>