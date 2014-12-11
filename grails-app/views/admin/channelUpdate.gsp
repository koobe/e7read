<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main" />
    <title>頻道資料維護</title>
</head>

<body>
<div class="container">

    <div class="page-header">
        <div class="btn-group pull-right" role="group">
            <g:link controller="admin" action="dashboard" class="btn btn-default">返回</g:link>
        </div>
        <h2>頻道資料維護</h2>
    </div>

    <g:form controller="admin" action="channelAdd" method="post" role="form" class="well" name="formChannelAdd" style="display: none">
        <div class="form-group">
            <label for="channelName">Channel Name</label>
            <input type="text" class="form-control" id="channelName" name="channelName" placeholder="Enter Channel Name" />
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
        <button type="submit" class="btn btn-default" id="btnFormCancel">Cancel</button>
    </g:form>

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
        $('#channelName').focus();
    });

    $('#btnFormCancel').click(function() {
        $('#formChannelAdd').hide('slow');
    });
});
</script>
</body>
</html>