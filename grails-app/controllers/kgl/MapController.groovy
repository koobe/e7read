package kgl

import grails.converters.JSON
import grails.plugin.geocode.Point

class MapController {
	
	def geocodingService

    def index() {}

    def explore() {

        String channel = getChannelName(params)

        log.info "Open map/explore with channel=${channel}"

        def lat = session['geolocation']?.lat
        def lon = session['geolocation']?.lon
        def zoom = 15

        if (lat == null || lon == null) {
            lat = message(code: 'default.location.lat').toDouble()
            lon = message(code: 'default.location.lon').toDouble()
            zoom = 12
        }

        if (params.center) {
            def latlon = params.center.split(',')

            lat = latlon[0].toString().toDouble()
            lon = latlon[1].toString().toDouble()
        }

        final String __CATEGORIES_QUERY = """
				select category
				from Category as category
				where enable = true and channel.name = :c
				order by rankOnTop asc
			"""

        [
                lat: lat,
                lon: lon,
                zoom: zoom,
                categories: Category.executeQuery(__CATEGORIES_QUERY, [c: channel])
        ]
    }

    def prompt() {
        def lat = session['geolocation']?.lat
        def lon = session['geolocation']?.lon
        def zoom = 15

        if (lat == null || lon == null) {
            lat = message(code: 'default.location.lat').toDouble()
            lon = message(code: 'default.location.lon').toDouble()
            zoom = 12
        }

        if (params.center) {
            def latlon = params.center.split(',')

            lat = latlon[0].toString().toDouble()
            lon = latlon[1].toString().toDouble()
        }

        [
                lat: lat,
                lon: lon,
                zoom: zoom
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
	
	def geocoding() {
		
		def lat = params.lat as double
		def lon = params.lon as double
		
		def addr = geocodingService.getAddress(new Point(latitude: lat, longitude: lon), [language: 'zh-TW'])
		
		def data = [:]
		
		data.country = addr.addressComponents[4].shortName //4
		data.city = addr.addressComponents[3].shortName //3
		data.region = addr.addressComponents[2].shortName //2
		data.address = addr.addressComponents[0].shortName //0

		render data as JSON
	}

    /**
     * Get channel name
     * @param params
     * @return
     */
    protected String getChannelName(params) {
        params.channel?:grailsApplication.config.grails.application.default_channel
    }

}
