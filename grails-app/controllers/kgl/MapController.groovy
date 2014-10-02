package kgl

import grails.plugin.springsecurity.annotation.Secured

class MapController {

    def index() {}

    def sample() {
        [
                lat: (session['geolocation']?.lat)?:25,
                lon: (session['geolocation']?.lon)?:121
        ]
    }
}
