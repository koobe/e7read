<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
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

    <g:form controller="admin" action="channelAdd" method="post" role="form" class="well" name="formChannelAdd"
            style="display: none">
        <div class="form-group">
            <label for="channelName">Channel Name</label>
            <input type="text" class="form-control" id="channelName" name="channelName"
                   placeholder="Enter Channel Name"/>
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
        <button type="submit" class="btn btn-default" id="btnFormCancel">Cancel</button>
    </g:form>

    <table class="table table-striped table-bordered table-hover table-responsive">
        <thead>
            <tr>
                <th width="32">Icon</th>
                <th>Channel Name</th>
                <th>Theme Type</th>
                <th>Is Default?</th>
                <th>Show In Panel?</th>
                <th>Allow Anonymous?</th>
                <th>Posts</th>
            </tr>
        </thead>
        <tbody>
        <g:each in="${channels}" var="channel">
            <tr>
                <td>
                    <img src="${channel.iconUrl}" class="img-responsive" />
                </td>
                <td>
                    <g:link controller="admin" action="channelUpdate" id="${channel.id}">
                        ${channel.name}
                    </g:link>
                </td>
                <td>
                    ${channel.themeType}
                </td>
                <td>
                    ${channel.isDefault}
                </td>
                <td>
                    ${channel.showInPanel}
                </td>
                <td>
                    ${channel.canAnonymous}
                </td>
                <td>
                    ${kgl.Content.countByChannel(channel)}
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(function () {
        $('#btnChannelAdd').click(function () {
            $('#formChannelAdd').show('slow');
            $('#channelName').focus();
        });

        $('#btnFormCancel').click(function () {
            $('#formChannelAdd').hide('slow');
        });
    });
</script>
</body>
</html>