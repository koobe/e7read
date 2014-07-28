<div class="koobe-header">
	<div class="header-logo">
		<g:link class="logo-text" url="/">
			<span class="glyphicon glyphicon-book logomark"></span>
			<span style="color: #d9534f;">K</span><span style="color: #5cb85c;">O</span><span style="color: #1A0B79;">O</span><span style="color: #5bc0de;">B</span><span style="color: #5cb85c;">E</span>
		</g:link>
	</div>
	<div class="header-search">
		
        <g:form uri="" role="search" class="" method="get">
        	<div class="input-group">
			    <g:textField id="text-search" name="q" class="form-control input-search" value="${params.q? params.q: ''}"/>
			    <span class="input-group-addon">
			        <i class="fa fa-search"></i>
			    </span>
		    </div>
		    <g:hiddenField name="from" value="0" />
			<g:hiddenField name="size" value="5" />
		</g:form>
	</div>
	<div class="header-usermenu">
		<g:render template="/home/usermenu" />
	</div>
</div>