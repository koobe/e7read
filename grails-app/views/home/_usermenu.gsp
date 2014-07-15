<%-- User Login --%>
<sec:ifLoggedIn>
	<div class="pull-right">
		<g:link controller="content" action="personal" class="btn btn-default">
	        <i class="fa fa-archive"></i> <!-- My Contents  -->
	    </g:link>
	    <g:link controller="content" action="create" class="btn btn-default">
	        <i class="fa fa-plus"></i> <!-- Create -->
	    </g:link>
	    <g:link uri="/me" class="btn btn-default">
	        <i class="fa fa-user"></i>
	        <!-- <sec:loggedInUserInfo field="fullName"/> -->
	    </g:link>
	    <g:link uri="javascript: confirmLogout();" class="btn btn-default">
	        <i class="fa fa-sign-out"></i> <!-- Logout -->
	    </g:link>
	</div>
</sec:ifLoggedIn>
<sec:ifNotLoggedIn>
	<div class="pull-right">
		<g:link uri="/login/auth" class="btn btn-default">
	        <i class="fa fa-sign-in"></i> <!-- Sign-in -->
	    </g:link>
	    <oauth:connect provider="facebook" id="facebook-connect-link" class="btn btn-default">
	        <i class="fa fa-facebook"></i>
	        <!-- Sign-in with Facebook -->
	    </oauth:connect>
	</div>
</sec:ifNotLoggedIn>