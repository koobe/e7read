<html>
<head>
    <meta name='layout' content='main'/>
    <title><g:message code="springSecurity.login.title"/></title>
    <style type="text/css">
    	body {
    		background-color: #FAF8F5;
    	}
    	
    	.title {
    		padding-top: 18px;
    		padding-bottom: 18px;
    		
    		font-size: 2em;
    		font-weight: 700;
    		letter-spacing: 1px;
    		
    		color: #444;
    	}
    	
    	.sub-title {
    		font-size: 1.1em;
    		font-weight: 300;
    		letter-spacing: 1px;
    		padding-bottom: 30px;
    		color: #888;
    		
    		font-family: Arial,sans-serif;
    	}
    	
    	.tip {
    		font-size: 0.8em;
    		line-height: 1.5em;
    		letter-spacing: 1px;
    		color: #888;
    		
    		padding: 20px 30px 0px 30px;
    	}
    	
    	.login-block {
    		border: 1px solid #ccd6dd;
    		border-radius: 4px;
    		background-color: #fff;
    		
    		text-align: center;
    		padding: 15px 10px 10px 10px;
    		margin: 0px auto;
    	}
    </style>
</head>
<body>

<div class="container">
	<nav>
		<g:render template="/home/section_title" model="[sectionTitle: 'Sign in', fontAwesome: '']"></g:render>
	</nav>
	
	<!-- 
    <div class="page-header">
        <h3><g:message code="springSecurity.login.header"/></h3>
    </div>
     -->
     
     <div class="title">Welcome to E7LIFE.</div>
     
     <div class="sub-title">Share everything around your nearby locations</div>
     
     <div class="login-block">
     	<oauth:connect provider="facebook" id="facebook-connect-link" class="btn btn-default">
	        <i class="fa fa-facebook-square"></i> Sign in with Facebook
	    </oauth:connect>
     
	     <div class="tip">
			Facebook帳號登入僅提供會員方便整合帳號，及會員之間的互動回應。若非經個人同意，不會在Facebook上留下足跡，亦不會自動發表分享。
	    </div>
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