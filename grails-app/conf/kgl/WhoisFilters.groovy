package kgl

class WhoisFilters {

    def geoIpService
    def whoisService

    def filters = {
        all(controller: '*', action: '*') {
            before = {
                // Update geolocation
                if (!session['geolocation']) {
                    def remoteAddr = whoisService.remoteAddr

                    def location = geoIpService.getLocation(remoteAddr)

                    if (location) {
                        log.info "RemoteAddr = ${remoteAddr}, lat: ${location.latitude}, lon: ${location.longitude}"
                        session['geolocation'] = [lat: location.latitude, lon: location.longitude]
                    }
                    else {
                        log.warn "RemoteAddr = ${remoteAddr} has no Geo IP data found"
                    }
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
