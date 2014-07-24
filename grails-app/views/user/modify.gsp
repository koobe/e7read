<html>
<head>
    <meta name="layout" content="main"/>
    <title>Modify User Profile</title>

    <script src="//cdn.ckeditor.com/4.4.1/standard/ckeditor.js"></script>
    <script src="//cdn.ckeditor.com/4.4.1/standard/adapters/jquery.js"></script>

</head>
<body>

<div class="container">

    <div class="page-header">
        <h1>Modify User Profie</h1>
    </div>

    <g:form action="modifySave" class="form-horizontal" role="form">
        <div class="form-group">
            <label for="username" class="col-sm-2 control-label">Username:</label>
            <div class="col-sm-10">
                <g:textField name="username" value="${user.username}" class="form-control" disabled="disabled" />
            </div>
        </div>

        <div class="form-group">
            <label for="fullName" class="col-sm-2 control-label">Full Name:</label>
            <div class="col-sm-10">
                <g:textField name="fullName" value="${user.fullName}" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label for="email" class="col-sm-2 control-label">E-Mail:</label>
            <div class="col-sm-10">
                <g:textField name="email" value="${user.email}" class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-12">
                <p class="text-center">--- Optional Fields ---</p>
            </div>
        </div>

        <div class="form-group">
            <label for="phone" class="col-sm-2 control-label">Phone:</label>
            <div class="col-sm-10">
                <g:textField name="phone" value="${user.phone}" class="form-control" placeholder="Phone Number"/>
            </div>
        </div>

        <div class="form-group">
            <label for="facebookUrl" class="col-sm-2 control-label">Facebook:</label>
            <div class="col-sm-10">
                <g:textField name="facebookUrl" value="${user.facebookUrl}" class="form-control" placeholder="http://facebook.com/YourFacebookID"/>
            </div>
        </div>

        <div class="form-group">
            <label for="blogUrl" class="col-sm-2 control-label">Blog:</label>
            <div class="col-sm-10">
                <g:textField name="blogUrl" value="${user.blogUrl}" class="form-control" placeholder="http://${user.username}.blogspot.com/"/>
            </div>
        </div>

        <div class="form-group">
            <label for="description" class="col-sm-2 control-label">Description:</label>
            <div class="col-sm-10">
                <g:textArea name="description" value="${user.description}" class="form-control" rows="5" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <g:submitButton name="save" value="Save" class="btn btn-default" />
                <g:link controller="user" action="profile" class="btn btn-default">Cancel</g:link>
            </div>
        </div>

    </g:form>

</div>

<script type="text/javascript">
$(function() {
    $('textarea#description').ckeditor();
});
</script>
</body>
</html>