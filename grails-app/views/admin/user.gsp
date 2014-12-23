<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>使用者管理</title>
    <style>
        td {

        }
    </style>
</head>

<body>

<div class="container">

    <div class="page-header">
        <div class="btn-group pull-right" role="group">
            <!--
            <button type="button" id="btnuserAdd" class="btn btn-default">
                <i class="fa fa-plus"></i>
                新增
            </button>
            -->
            <g:link controller="admin" action="dashboard" class="btn btn-default">返回</g:link>
        </div>

        <h2>使用者管理</h2>
    </div>

    <g:form controller="admin" action="userAdd" method="post" role="form" class="well" name="formuserAdd"
            style="display: none">
        <div class="form-group">
            <label for="userName">user Name</label>
            <input type="text" class="form-control" id="userName" name="userName"
                   placeholder="Enter user Name"/>
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
        <button class="btn btn-default" id="btnFormCancel">Cancel</button>
    </g:form>

    <table class="table table-striped table-bordered table-hover table-responsive">
        <thead>
            <tr>
                <th>UID</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>Auth Type</th>
                <th>Facebook ID</th>
                <th>E-Mail</th>
                <th>Location</th>
            </tr>
        </thead>
        <tbody>
        <g:each in="${users}" var="user">
            <tr>
                <td>
                    ${user.id}
                </td>
                <td>
                    <!-- controller="admin" action="userUpdate" -->
                    <g:link uri="#" id="${user.id}">
                        ${user.username}
                    </g:link>
                </td>
                <td>
                    ${user.fullName}
                </td>
                <td>
                    ${user.authType}
                </td>
                <td>
                    ${user.facebookId}
                </td>
                <td>
                    ${user.email}
                </td>
                <td>
                    <g:if test="${user.location}">
                        ${user.location?.lat},${user.location?.lon}
                    </g:if>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(function () {
        $('#btnuserAdd').click(function () {
            $('#formuserAdd').show('slow');
            $('#userName').focus();
        });

        $('#btnFormCancel').click(function () {
            $('#formuserAdd').hide('slow');
            return false;
        });
    });
</script>
</body>
</html>