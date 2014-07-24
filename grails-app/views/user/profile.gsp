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
            <label class="col-sm-2 control-label">Description:</label>
            <div class="col-sm-10">
                <pre class="form-control-static">${user.description}</pre>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <g:link uri="/" class="btn btn-default">Done</g:link>
            </div>
        </div>

    </form>

</div>

</body>
</html>