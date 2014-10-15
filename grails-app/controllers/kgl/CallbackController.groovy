package kgl

import grails.converters.JSON

class CallbackController {

    def springSecurityService

    def geolocation() {

        if (!params.lat || !params.lon) {
            render "error"
            return
        }

//        if (session['geolocation']) {
//            render "exist"
//            return
//        }

        // Update location after login process
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

        session['geolocation'] = [lat: params.lat, lon: params.lon]

        render session['geolocation'] as JSON
    }

    def debugGeolocation() {
        render GeoPoint.list() as JSON
    }
}
