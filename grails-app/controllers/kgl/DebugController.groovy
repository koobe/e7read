package kgl

import grails.converters.JSON
import grails.plugin.geocode.Point
import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class DebugController {

    def geocodingService

    def s3Service
    //def geoIpService
    //def whoisService

    def index() {

        grailsApplication.config.flatten().entrySet().each {
            log.info it
        }

        [
                actions: [
                        'aws',
                        's3file'
                ]
        ]
    }

    def aws() {

        def result = [
                s3_default_bucket_exists: s3Service.doesBucketExist()
        ]

        render result as JSON
    }

    def s3file() {
        render S3File.list() as JSON
    }

    def rds() {

        def result = [
                RDS_DB_NAME: System.getProperty("RDS_DB_NAME"),
                RDS_USERNAME: System.getProperty("RDS_USERNAME"),
                RDS_PASSWORD: System.getProperty("RDS_PASSWORD"),
                RDS_HOSTNAME: System.getProperty("RDS_HOSTNAME"),
                RDS_PORT: System.getProperty("RDS_PORT"),
                JDBC_CONNECTION_STRING: System.getProperty("JDBC_CONNECTION_STRING")
        ]

        render result as JSON
    }

    def email() {
        sendMail {
            to "lyhcode@gmail.com"
            subject "Hello Fred"
            body 'How are you?'
        }

        def result = [
                result: true
        ]

        render result as JSON
    }

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def geocoding() {

        def addr = geocodingService.getAddress(new Point(latitude: 24.2201031, longitude: 120.9558744), [language: 'zh-TW'])

        def result = [:]

        addr.addressComponents.each {
            component ->

                if (component.types.contains('postal_code')) {
                    result.postalCode = component.shortName
                }
                else if (component.types.contains('political')) {
                    if (component.types.contains('country')) {
                        result.country = component.longName
                    }
                    else if (component.types.contains('administrative_area_level_1')) {
                        result.city = component.longName
                    }
                    else if (component.types.contains('administrative_area_level_2')) {
                        result.city = component.longName
                    }
                    else if (component.types.contains('administrative_area_level_3')) {
                        result.region = component.longName
                    }
                }
                else if (component.types.contains('route')) {
                    result.address = component.longName
                }
        }
        result.place = addr.formattedAddress

        result.source = addr

        render result as JSON
    }

    def geopoint() {
        render GeoPoint.list() as JSON
    }

    def geoip() {
        //render "${geoIpService.getLocation("168.95.1.1").countryCode}"

        /*
        def remoteAddr = params.ip?:whoisService.remoteAddr

        def location = geoIpService.getLocation(remoteAddr)
        render ([
                remoteAddr: remoteAddr,
                countryCode: location?.countryCode,
                countryName: location?.countryName,
                city: location?.city,
                region: location?.region,
                latitude: location?.latitude,
                longitude: location?.longitude
        ] as JSON)
        */

        render 'deprecated'
    }
}
