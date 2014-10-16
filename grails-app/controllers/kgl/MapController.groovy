package kgl

import grails.plugin.springsecurity.annotation.Secured

class MapController {

    def index() {}

    def explore() {

        def lat = (session['geolocation']?.lat)?:25

        def lon = (session['geolocation']?.lon)?:121

        if (params.center) {
            def latlon = params.center.split(',')

            lat = latlon[0]
            lon = latlon[1]
        }

        [
                lat: lat,
                lon: lon,
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
