<html>
<head>
    <meta name='layout' content='main'/>
    <title><g:message code="springSecurity.login.title"/></title>
</head>
<body>

<div class="container">
    <div class="page-header">
        <h3><g:message code="springSecurity.login.header"/></h3>
    </div>

    <g:if test='${flash.message}'>
        <div class='login_message'>${flash.message}</div>
    </g:if>

    <g:if test="${isAdmin}">
        <form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
            <p>
                <label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
                <input type='text' class='text_' name='j_username' id='username'/>
            </p>

            <p>
                <label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
                <input type='password' class='text_' name='j_password' id='password'/>
            </p>

            <p id="remember_me_holder">
                <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                <label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
            </p>

            <p>
                <input type='submit' id="submit" value='${message(code: "springSecurity.login.button")}' class="btn btn-primary"/>
                <g:link uri="/" class="btn btn-default">Cancel</g:link>
            </p>
        </form>

        <hr class="soften" />
    </g:if>

    <oauth:connect provider="facebook" id="facebook-connect-link" class="btn btn-default">
        <i class="fa fa-facebook-square"></i>
        Sign-in with Facebook
    </oauth:connect>

    <div style="margin-top: 30px">
        <g:link uri="javascript: history.back();" class="btn btn-default">Back</g:link>
    </div>
</div>
<script type='text/javascript'>
    <!--
    (function() {
        document.forms['loginForm'].elements['j_username'].focus();
    })();
    // -->
</script>
</body>
</html>