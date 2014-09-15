<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
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

    <div class="row">
        <div class="col-xs-6">
            <input class="form-control friendly-url" type="text" value="${createLink(controller: 'content', action: 'modifyByHash', params: [hash: hashcode], absolute: true)}" readonly style="cursor: pointer" />
        </div>
        <div class="col-xs-6">
            <button class="btn btn-default friendly-url-copy" style="display: none">Copy to clipboard</button>
        </div>
    </div>
    
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

    $(function() {
        $('.friendly-url').click(function() {
            $(this).select();
        });
        $('.friendly-url-copy').click(function() {
        });

        $('.editing-title-switch').click(function(e) {
	    		if (onoff) {
	    			onoff = false;
	    			$('.editing-title-box').css('display', 'none');
	    		} else {
	    			onoff = true;
	    			$('.editing-title-box').css('display', 'block');
	    		}
	    	});

    		$('.action-click-delete').click(function(e) {
			var c = confirm("Are you sure to delete?");
			if (c) {
				var hashcode = $('.action-click-delete').data('hashcode');
				window.location.replace("/content/disableByHashcode/" + hashcode);
			}
        	});
    });
    
</script>
</body>
</html>