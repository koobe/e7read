package kgl

import grails.util.Holders

class FacebookTagLib {
    //static defaultEncodeAs = [taglib: 'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    def grailsApplication

    static namespace = "fb"

    def init = { attrs, body ->
        def fbAppId = grailsApplication.config.grails.facebook.app.id

        out <<
"""
<div id="fb-root"></div>
<script>(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/zh_TW/sdk.js#xfbml=1&appId=${fbAppId}&version=v2.0";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
"""
    }

    def share = { attr, body ->
        out <<
		"""
			<div class="fb-share-button" data-href="${attr.href}"></div>
		"""
    }
	
	def comments = { attr, body -> 
		def serverUrl = grailsApplication.config.grails.serverURL;
		out <<
		"""
			<div class="fb-comments" data-href="${serverUrl}/share/${attr.contentid}" data-width="100%" data-numposts="5" data-colorscheme="light"></div>
		"""
	}

}
