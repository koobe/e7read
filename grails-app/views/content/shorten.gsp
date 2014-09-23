<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <meta name="sendmail-url" content="${createLink(controller: 'content', action: 'ajaxSendShortenMail', id: content.id)}" />
    <title></title>
    <style type="text/css">
    		.editing-title-switch {
    			cursor: pointer;
    		}
    		.editing-title-box {
    			display: none;
    			border: 1px solid #AAA;
    			border-radius: 5px;
    			padding: 10px 10px 10px 10px;
    			background-color: #eee;
    			margin-right: 15px;
    			margin-left: 15px;
    		}
    </style>
</head>
<body>

	<div id="display-container">
		<g:render template="/home/header" model="[showcategorymenu: true]" />
	</div>
	
	<div class="container" style="padding-top: 40px;">
	    <div style="text-align: center;" class="alert alert-success">
	    		<span>Congratulation! Your post has been published.</span>
	    </div>
	</div>

<div class="container">
    <p>Content code is:</p>
    <p><code style="font-size:200%;">${hashcode}</code></p>


    <p>If you need to re-edit this content in the future, please use the following url:</p>
    <p><g:link controller="content" action="modifyByHash" params="[hash: hashcode]">${createLink(controller: 'content', action: 'modifyByHash', params: [hash: hashcode], absolute: true)}</g:link></p>


    <!--
    <input class="form-control friendly-url" type="text" value="${createLink(controller: 'content', action: 'modifyByHash', params: [hash: hashcode], absolute: true)}" readonly style="cursor: pointer" />
    -->

    <button class="btn btn-default friendly-url-copy" style="display: none">Copy to clipboard</button>
    <button class="btn btn-default send-email-button">
        <i class="fa fa-square-o"></i>
        <i class="fa fa-check-square-o" style="display: none"></i>
        Send E-Mail
    </button>

    <div class="col-xs-12 well send-email-container" style="margin-top: 20px;display: none">

        <h3>Backup URL to your mailbox</h3>

        <div class="form-group">
            <label for="toEmailAddress">To Address:</label>
            <input id="toEmailAddress" class="form-control" placeholder="e.g. yourname@example.com" />
        </div>

        <button class="btn btn-primary send-email-submit-button">
            <i class="fa fa-spinner fa-spin" style="display: none"></i>
            Send Mail
        </button>
        <button class="btn btn-default send-email-cancel-button">Cancel</button>
    </div>

    <br/>
    <br/>
    <br/>
    
    <div class="editing-title-switch">
		<p><i class="fa fa-pencil"></i> Edit Title & Description</p>
	</div>
	
	<div class="editing-title-box">
		<g:form name="updateTitleForm" controller="content" action="shorten">
			<div class="form-group">
				<label>Title</label>
				<g:textField name="updateTitle" class="form-control" value="${content.cropTitle}" />
			</div>
			<div class="form-group">
				<label>Description</label>
				<g:textArea name="updateDesc" class="form-control" value="${content.cropText}" rows="5" cols="40"/>
			</div>
			<div class="form-group">
				<label>Reference</label>
				<g:textField name="updateReference" class="form-control" value="${content.references}" />
			</div>
			<button type="submit" class="btn btn-default">Update</button>
		</g:form>
	</div>

    <br/>

    <g:link uri="/share/${contentId}" class="btn btn-default">View Content</g:link>
    
    <g:link data-hashcode="${hashcode}" uri="#" class="btn btn-danger action-click-delete">Delete Content</g:link>
</div>

<g:render template="/home/footer" />
		
<g:include controller="category" action="addCategoryPanel" params="[btnaction: 'home']" />

<script type="text/javascript">

    var onoff = false;

    $(function () {
        $('.friendly-url').click(function () {
            $(this).select();
        });
        $('.friendly-url-copy').click(function () {
        });

        $('.editing-title-switch').click(function (e) {
            if (onoff) {
                onoff = false;
                $('.editing-title-box').css('display', 'none');
            } else {
                onoff = true;
                $('.editing-title-box').css('display', 'block');
            }
        });

        $('.action-click-delete').click(function (e) {
            var c = confirm("Are you sure to delete?");
            if (c) {
                var hashcode = $('.action-click-delete').data('hashcode');
                window.location.replace("/content/disableByHashcode/" + hashcode);
            }
        });

        $('.send-email-button').click(function() {

            $('.send-email-button').hide();
            $('.send-email-container').show();

        });

        $('.send-email-submit-button').click(function() {

            var addr = $('#toEmailAddress').val();
            if (!addr) {
                alert("Must enter a valid email address.");
                return;
            }

            $('.send-email-submit-button').attr('disabled', 'disabled');
            $('.send-email-submit-button i').show();

            var ajax_url = $('meta[name=sendmail-url]').attr('content');
            $.get(ajax_url, {to: addr}).done(function(data) {
                if (data && data.result && data.result == true) {
                    //alert('Reminder mail sent.');

                    $('.send-email-button').show();
                    $('.send-email-container').hide();

                    $('.send-email-button i').eq(0).hide();
                    $('.send-email-button i').eq(1).show();
                }
            });
        });

        $('.send-email-cancel-button').click(function() {
            $('.send-email-button').show();
            $('.send-email-container').hide();
        });

    });
    
</script>
</body>
</html>