package kgl

import grails.plugin.springsecurity.annotation.Secured

class MapController {

    def index() {}

    def explore() {
        [
                lat: (session['geolocation']?.lat)?:25,
                lon: (session['geolocation']?.lon)?:121,
                zoom: session['geolocation']?15:10,
        ]
    }
	
	def content(Content content) {
		[
			lat: (content.location?.lat)?:25,
			lon: (content.location?.lon)?:121,
			zoom: 15,
			content: content
		]
	}
}
