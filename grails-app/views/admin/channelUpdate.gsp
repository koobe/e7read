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

    <g:form controller="admin" action="channelUpdateSave" id="${channel.id}" method="post" role="form" class="well" name="formChannelUpdate">
        <div class="form-group">
            <label>Channel ID</label>
            <p>${channel.id}</p>
        </div>

        <div class="form-group">
            <label for="name">Channel Name</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="Enter Channel Name" value="${channel.name}" />
        </div>

        <div class="form-group">
            <label for="isDefault">Is Default?</label>
            <div>
                <g:radioGroup values="[true,false]" value="${channel.isDefault}" labels="['Yes','No']" name="isDefault">
                    <label>
                        ${it.radio} ${it.label}
                    </label>
                </g:radioGroup>
            </div>
        </div>

        <div class="form-group">
            <label for="isDefault">Show In Panel?</label>
            <div>
                <g:radioGroup values="[true,false]" value="${channel.showInPanel}" labels="['Yes','No']" name="showInPanel">
                    <label>
                        ${it.radio} ${it.label}
                    </label>
                </g:radioGroup>
            </div>
        </div>

        <div class="form-group">
            <label for="isDefault">Allow Anonymous?</label>
            <div>
                <g:radioGroup values="[true,false]" value="${channel.canAnonymous}" labels="['Yes','No']" name="canAnonymous">
                    <label>
                        ${it.radio} ${it.label}
                    </label>
                </g:radioGroup>
            </div>
        </div>

        <div class="form-group text-right">
            <label>
                <g:checkBox name="delete" /> <span class="text-danger">Delete this channel (be careful)!</span>
            </label>
        </div>


        <button type="submit" class="btn btn-default">Update</button>
        <button type="submit" class="btn btn-default" id="btnFormCancel">Cancel</button>
    </g:form>

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