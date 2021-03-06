<%-- User Login --%>
<sec:ifLoggedIn>
	<div class="usermenu-table">
		<!-- 
		<g:if test="${showChannelButton}">
			<div class="header-menu-channel">
				<g:link uri="javascript:showChannelMenu();" class="koobe-btn koobe-btn-normal">
			        <i class="fa fa-bookmark"></i>
			    </g:link>
		    </div>
		</g:if> -->
	    
		<div class="header-menu-personal">
			<g:link uri="/content/personal/${channel.name}" class="koobe-btn koobe-btn-normal">
		        <i class="fa fa-archive"></i> <!-- My Contents  -->
		    </g:link>
	    </div>
	    <div class="header-menu-create" >
            <g:link uri="/content/create/${channel.name}" class="koobe-btn koobe-btn-normal">
                <i class="fa fa-pencil"></i> <!-- Create -->
            </g:link>
	    </div>
	    <div class="header-menu-profile" >
            <g:link uri="/me" class="koobe-btn koobe-btn-normal">
                <i class="fa fa-user"></i>
                <!-- <sec:loggedInUserInfo field="fullName"/> -->
            </g:link>
	    </div>
	    <div class="header-menu-message"  style="margin-bottom: -20px; margin-right: -16px">
            <g:link uri="/message/index" class="koobe-btn koobe-btn-normal">
                <i class="fa fa-envelope"></i>
            </g:link>
            <div id="unread-message-count" style="
	            color: red; 
	            font-size: 0.6em; 
	            font-weight: 700; 
	            position: relative; 
	            top: 7px;
	            left: -16px;
	            ">0</div>
	    </div>
	    <!-- 
        <div class="header-menu-map" >
            <g:link controller="map" action="explore" params="[channel: channel.name]" class="koobe-btn koobe-btn-normal">
                <i class="fa fa-map-marker"></i>
            </g:link>
        </div> -->
        
        <div class="header-menu-logout" >
            <g:link uri="javascript: confirmLogout();" class="koobe-btn koobe-btn-normal">
                <i class="fa fa-sign-out"></i> <!-- Logout -->
            </g:link>
	    </div>
	    <div class="menu-blank">&nbsp;</div>
	</div>
</sec:ifLoggedIn>
<sec:ifNotLoggedIn>
	<div class="usermenu-table">
		<!-- 
		<g:if test="${showChannelButton}">
			<div class="header-menu-channel" >
				<g:link uri="javascript:showChannelMenu();" class="koobe-btn koobe-btn-normal">
			        <i class="fa fa-bookmark"></i>
			    </g:link>
		    </div>
		</g:if> -->
	
		<g:if test="${channel.canAnonymous}">
	        <div class="header-menu-create" >
	            <g:link uri="/content/create/${channel.name}" class="koobe-btn koobe-btn-normal">
	                <i class="fa fa-pencil"></i> <!-- Create -->
	            </g:link>
	        </div>
        </g:if>
        
        <!-- 
        <div class="header-menu-map">
            <g:link controller="map" action="explore" params="[channel: channel.name]" class="koobe-btn koobe-btn-normal">
                <i class="fa fa-map-marker"></i>
            </g:link>
        </div> -->
        
		<div class="header-menu-login">
			<!-- 
			<oauth:connect provider="facebook" id="facebook-connect-link" class="koobe-btn koobe-btn-normal">
		        <span class="fa fa-facebook-square"></span>
		        <!-- Sign-in with Facebook
		    </oauth:connect> -->
		    <g:link uri="/login/auth" class="koobe-btn koobe-btn-normal">
                <i class="fa fa-sign-in"></i>
            </g:link>
		</div>
		<div class="menu-blank">&nbsp;</div>
	</div>
</sec:ifNotLoggedIn>