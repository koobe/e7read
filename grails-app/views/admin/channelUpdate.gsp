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
            <g:textField name="name" value="${channel.name}" class="form-control" placeholder="Enter Channel Name" />
        </div>

        <div class="form-group">
            <label for="iconUrl">Icon URL</label>
            <g:textField name="iconUrl" value="${channel.iconUrl}" class="form-control" />
        </div>

        <div class="form-group">
            <label for="smallLogoUrl">Small Logo URL</label>
            <g:textField name="smallLogoUrl" value="${channel.smallLogoUrl}" class="form-control" />
        </div>

        <div class="form-group">
            <label for="logoImg">Logo Image</label>
            <g:textField name="logoImg" value="${channel.logoImg}" class="form-control" />
        </div>

        <div class="form-group">
            <label for="themeType">Theme Type</label>
            <g:textField name="themeType" value="${channel.themeType}" class="form-control" />
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
            <label for="showInPanel">Show In Panel?</label>
            <div>
                <g:radioGroup values="[true,false]" value="${channel.showInPanel}" labels="['Yes','No']" name="showInPanel">
                    <label>
                        ${it.radio} ${it.label}
                    </label>
                </g:radioGroup>
            </div>
        </div>

        <div class="form-group">
            <label for="canAnonymous">Allow Anonymous?</label>
            <div>
                <g:radioGroup values="[true,false]" value="${channel.canAnonymous}" labels="['Yes','No']" name="canAnonymous">
                    <label>
                        ${it.radio} ${it.label}
                    </label>
                </g:radioGroup>
            </div>
        </div>

        <div class="form-group">
            <label>Virtual Hosts</label>
            <div>

                <select style="height:10em" class="form-control" multiple>
                    <g:each in="${hosts}" var="host">
                        <option>${host.hostname}</option>
                    </g:each>
                </select>

            </div>
        </div>


        <div class="form-group text-right">
            <label>
                <g:checkBox name="delete" /> <span class="text-danger">Delete this channel (be careful)!</span>
            </label>
        </div>

        <button type="submit" class="btn btn-primary">Update</button>
        <g:link controller="admin" action="channel" class="btn btn-default">Cancel</g:link>
    </g:form>

</div>

<script type="text/javascript">
$(function() {

});
</script>
</body>
</html>