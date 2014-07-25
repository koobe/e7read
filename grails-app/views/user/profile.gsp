<html>
<head>
    <meta name="layout" content="main"/>
    <title></title>
</head>
<body>

<div class="container">

    <div class="page-header">
        <h1>User Profie</h1>
    </div>

    <form class="form-horizontal" role="form">
        <div class="form-group">
            <label class="col-sm-2 control-label">Username:</label>
            <div class="col-sm-10">
                <p class="form-control-static">${user.username}</p>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Full Name:</label>
            <div class="col-sm-10">
                <p class="form-control-static">${user.fullName}</p>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">E-Mail:</label>
            <div class="col-sm-10">
                <p class="form-control-static">${user.email}</p>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Phone:</label>
            <div class="col-sm-10">
                <div class="form-control-static">${user.phone}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Facebook:</label>
            <div class="col-sm-10">
                <div class="form-control-static">${user.facebookUrl}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Blog:</label>
            <div class="col-sm-10">
                <div class="form-control-static">${user.blogUrl}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">LINE:</label>
            <div class="col-sm-10">
                <div class="form-control-static">${user.lineId}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Skype:</label>
            <div class="col-sm-10">
                <div class="form-control-static">${user.skypeId}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Description:</label>
            <div class="col-sm-10">
                <div class="form-control-static">${user.description?.encodeAsRaw()}</div>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <g:link controller="user" action="modify" class="btn btn-default">Modify</g:link>
                <g:link uri="/" class="btn btn-default">Done</g:link>
            </div>
        </div>

    </form>

</div>

</body>
</html>