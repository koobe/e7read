<html>
<head>
    <meta name="layout" content="main"/>
    <title></title>
    
    <style type="text/css">
    	body {
    		background-color: #FAF8F5;
    	}
	</style>
    
</head>
<body>
<g:render template="/home/header_v2" />

<div class="container" style="max-width: 900px;">

	<nav>
		<g:render template="/home/section_title" model="[sectionTitle: 'Profile', fontAwesome: 'fa-user']"></g:render>
	</nav>

    <form class="form-horizontal" role="form">
    
        <div class="form-group">
            <label class="col-xs-3 control-label">Username:</label>
            <div class="col-xs-9">
                <p class="form-control-static">${user.username}</p>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Full Name:</label>
            <div class="col-xs-9">
                <p class="form-control-static">${user.fullName}</p>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Email:</label>
            <div class="col-xs-9">
                <p class="form-control-static">${user.email}</p>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Phone:</label>
            <div class="col-xs-9">
                <div class="form-control-static">${user.contact?.phone}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Facebook:</label>
            <div class="col-xs-9">
                <div class="form-control-static">${user.contact?.facebookUrl}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Blog:</label>
            <div class="col-xs-9">
                <div class="form-control-static">${user.contact?.blogUrl}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">LINE:</label>
            <div class="col-xs-9">
                <div class="form-control-static">${user.contact?.lineId}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Skype:</label>
            <div class="col-xs-9">
                <div class="form-control-static">${user.contact?.skypeId}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Description:</label>
            <div class="col-sm-9">
                <div class="form-control-static">${user.contact?.description?.encodeAsRaw()}</div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Location:</label>
            <div class="col-xs-9">
                <div class="form-control-static"><i class="fa fa-map-marker"></i> ${user.location?.city}<br/></div>
            </div>
        </div>

    </form>
    
    <div>
    	<img src="http://maps.googleapis.com/maps/api/staticmap?center=${user.location?.lat},${user.location?.lon}&zoom=14&size=960x250&scale=2&sensor=false" alt="google map" border="0" class="img-thumbnail" style="width:100%;"/>
    </div>
    
    <div class="" style="float:right; padding-top: 20px;">
        <g:link controller="user" action="modify" class="koobe-text-btn koobe-text-btn-inverse">編輯 Modify</g:link>
    </div>

</div>

<g:render template="/home/footer" />

</body>
</html>