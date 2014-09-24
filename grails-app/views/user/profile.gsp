<html>
<head>
    <meta name="layout" content="main"/>
    <title></title>
</head>
<body>
<g:render template="/home/header" />

<div class="container">
	
    <div class="page-header">
        <h4>User Profie</h4>
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
                <div class="form-control-static">${user.contact?.phone}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Facebook:</label>
            <div class="col-sm-10">
                <div class="form-control-static">${user.contact?.facebookUrl}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Blog:</label>
            <div class="col-sm-10">
                <div class="form-control-static">${user.contact?.blogUrl}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">LINE:</label>
            <div class="col-sm-10">
                <div class="form-control-static">${user.contact?.lineId}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Skype:</label>
            <div class="col-sm-10">
                <div class="form-control-static">${user.contact?.skypeId}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Description:</label>
            <div class="col-sm-10">
                <div class="form-control-static">${user.contact?.description?.encodeAsRaw()}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">Location:</label>
            <div class="col-sm-10">
                <img src="http://maps.googleapis.com/maps/api/staticmap?center=${user.location.lat},${user.location.lon}&zoom=14&size=400x150&sensor=false" alt="google map" border="0" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-10">
                <g:link controller="user" action="modify" class="koobe-text-btn koobe-text-btn-inverse">編輯 Modify</g:link>
                <!-- <g:link uri="/" class="btn btn-default">Done</g:link> -->
            </div>
        </div>

    </form>

</div>

</body>
</html>