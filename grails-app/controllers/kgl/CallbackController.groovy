package kgl

import grails.converters.JSON

class CallbackController {

    def springSecurityService

    def geolocation() {

        if (!params.lat || !params.lon) {
            render "error"
            return
        }

        if (session['geolocation']) {
            render "exist"
            return
        }

        // Update location after login process
//        if (springSecurityService.isLoggedIn()) {
//            User user =  springSecurityService.currentUser
//
//            if (user) {
//                def location = new GeoPoint(lat: params.lat, lon: params.lon)
//                location.save(flush: true)
//
//                user.location = location
//                user.save(flush: true)
//            }
//        }

        session['geolocation'] = [lat: params.lat, lon: params.lon]
        render "ok"
    }

    def debugGeolocation() {
        render GeoPoint.list() as JSON
    }
}
