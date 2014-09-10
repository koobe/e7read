$(function() {
	function receiveMessage(event) {
		console.log('Receive message: ' + event.data);
		var data = event.data;
		console.log(data.imageUrl);
		console.log(data.imageArray);
		
		var imageview = $.imageview({imageUrl: data.imageUrl, imageArray: data.imageArray});
		imageview.openView(data.imageUrl);
	}
	
	window.addEventListener("message", receiveMessage, false);
});

