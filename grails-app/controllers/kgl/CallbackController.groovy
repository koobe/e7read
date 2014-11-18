package kgl

import grails.converters.JSON
import grails.plugin.geocode.Point

class CallbackController {

    def springSecurityService

    def geocodingService

    def geolocation() {

        if (params.lat == null || params.lon == null) {
            render "error"
            return
        }

//        if (session['geolocation']) {
//            render "exist"
//            return
//        }

        // Update location after login process
        /*
        if (springSecurityService.isLoggedIn()) {
            User user =  springSecurityService.currentUser

            if (user) {

                if (!user.location) {
                    user.location = new GeoPoint()
                }

                user.location.lat = Double.parseDouble(params.lat)
                user.location.lon = Double.parseDouble(params.lon)

                user.location.save flush: true

                user.save flush: true
            }
        }
        */

        if (!session['geolocation']) {
            def lat = Float.parseFloat(params.lat)
            def lon = Float.parseFloat(params.lon)

            def addr = geocodingService.getAddress(new Point(latitude: lat, longitude: lon), [language: 'zh-TW'])

            def country = addr.addressComponents[4].shortName //4
            def city = addr.addressComponents[3].shortName //3
            def region = addr.addressComponents[2].shortName //2
            def address = addr.addressComponents[0].shortName //0

            session['geolocation'] = [
                    lat: lat,
                    lon: lon,
                    display: "${city}${region}"
            ]
        }

        render session['geolocation'] as JSON
    }

    def debugGeolocation() {
        render GeoPoint.list() as JSON
    }
}
