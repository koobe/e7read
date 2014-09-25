package kgl

import grails.plugin.geocode.Point

class GeoPoint {

    Double lat
    Double lon

    String country
    String city
    String region
    String address

    def geocodingService

    static searchable = {
        root false
    }

    static constraints = {
        country nullable: true
        city nullable: true
        region nullable: true
        address nullable: true
    }

    def beforeInsert() {
        geocoding()
    }

    def beforeUpdate() {
        geocoding()
    }

    protected void geocoding() {
        def addr = geocodingService.getAddress(new Point(latitude: lat, longitude: lon), [language: 'zh-TW'])

        country = addr.addressComponents[4].shortName //4
        city = addr.addressComponents[3].shortName //3
        region = addr.addressComponents[2].shortName //2
        address = addr.addressComponents[0].shortName //0
    }
}
