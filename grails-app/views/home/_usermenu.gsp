<%-- User Login --%>
<sec:ifLoggedIn>
	<div class="usermenu-table">
		<div>
			<g:link controller="content" action="personal" class="btn btn-default">
		        <i class="fa fa-archive"></i> <!-- My Contents  -->
		    </g:link>
	    </div>
	    <div>
	    <g:link controller="content" action="create" class="btn btn-default">
	        <i class="fa fa-plus"></i> <!-- Create -->
	    </g:link>
	    </div>
	    <div>
	    <g:link uri="/me" class="btn btn-default">
	        <i class="fa fa-user"></i>
	        <!-- <sec:loggedInUserInfo field="fullName"/> -->
	    </g:link>
	    </div>
	    <div>
	    <g:link uri="javascript: confirmLogout();" class="btn btn-default">
	        <i class="fa fa-sign-out"></i> <!-- Logout -->
	    </g:link>
	    </div>
	</div>
</sec:ifLoggedIn>
<sec:ifNotLoggedIn>
	<div class="usermenu-table">
		<div>
			<oauth:connect provider="facebook" id="facebook-connect-link" class="btn btn-default">
		        <span class="fa fa-facebook-square"></span>
		        <!-- Sign-in with Facebook -->
		    </oauth:connect>
		</div>
	</div>
		<!-- 
		<g:link uri="/login/auth" class="btn btn-default">
	        <i class="fa fa-sign-in"></i> <!-- Sign-in
	    </g:link> -->
</sec:ifNotLoggedIn>