/**
 * @author cloude
 */

$(function() {
	
	// use message manager
	var messagemanager = $.messagemanager();
	
	// register an action and handler
	messagemanager.registerHandler('openImageView', function(data) {
		console.log(data.imageUrl);
		console.log(data.imageArray);
		var imageview = $.imageview({imageUrl: data.imageUrl, imageArray: data.imageArray});
		imageview.openView(data.imageUrl);
	});
	
	// start listen message
	messagemanager.addMessageEvnetListener();
});

