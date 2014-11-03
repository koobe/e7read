package kgl

import grails.plugin.springsecurity.annotation.Secured

class MapController {

    def index() {}

    def explore(String channel) {

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

    /**
     * Get channel name
     * @param params
     * @return
     */
    protected String getChannelName(params) {
        params.channel?:grailsApplication.config.grails.application.default_channel
    }

}
