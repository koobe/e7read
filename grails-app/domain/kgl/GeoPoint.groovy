package kgl

import grails.plugin.geocode.Point

class GeoPoint {
	
	def geocodingService
	
	static searchable = {
		root false
//		only = ['id', 'lat', 'lon', 'country', 'city']
//		
//		country index: "no"
//		city index: "no"
	}
	
	Long id

    Double lat
    Double lon

    String custom
    String place

    String postalCode

    String country
    String city
    String region
    String address

    static constraints = {
        custom nullable: true, blank: true
        place nullable: true, blank: true
        postalCode nullable: true, blank: true

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

        addr.addressComponents.each { component ->

            if (component.types.contains('postal_code')) {
                postalCode = component.shortName
            }
            else if (component.types.contains('political')) {
                if (component.types.contains('country')) {
                    country = component.longName
                }
                else if (component.types.contains('administrative_area_level_1')) {
                    city = component.longName
                }
                else if (component.types.contains('administrative_area_level_2')) {
                    city = component.longName
                }
                else if (component.types.contains('administrative_area_level_3')) {
                    region = component.longName
                }
            }
            else if (component.types.contains('route')) {
                address = component.longName
            }
        }

        place = addr.formattedAddress
    }
	
	def getLocationName() {
		
		def locationName = ''
		
		if (country == null && city == null && region == null && address == null) {
			geocoding()
		}
		
		def ls = []
		
		if (country) {
			ls.add(country)
		}
		if (city) {
			ls.add(city)
		}
		if (region) {
			ls.add(region)
		}
		
		return ls.join('')
	}
}
