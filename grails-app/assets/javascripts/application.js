// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better 
// to create separate JavaScript files as needed.
//
//= require jquery
//= require bootstrap
//= require jquery.editable
//= require grails.frontend
//= require_self

if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}

function confirmLogout() {
//	var r = confirm('Logout?');
//	if (r) {
		var channel = getQueryVariable("channel")
		if (channel) {
			window.location.replace("/logout/index?channel=" + channel);
		} else {
			window.location.replace("/logout/index?channel=e7read");
		}
//	}
}

function getQueryVariable(variable) {
   var query = window.location.search.substring(1);
   var vars = query.split("&");
   for (var i=0;i<vars.length;i++) {
           var pair = vars[i].split("=");
           if(pair[0] == variable){return pair[1];}
   }
   var meta = $("meta[name='params-"+variable+"']").attr('content');
   if (meta) { return meta; }
   return(false);
}

var E7READ = {};
E7READ.CHANNEL = getQueryVariable('channel');
