package kgl

import org.codehaus.groovy.grails.web.util.WebUtils

class WhoisService {

    //static scope = "request"

    def getRemoteAddr() {
        def request = WebUtils.retrieveGrailsWebRequest().currentRequest
        def ip1 = request.remoteAddr
        def ip2 = request.getHeader("X-Forwarded-For")
        def ip3 = request.getHeader("Client-IP")

        if (ip3) {
            return ip3
        }
        if (ip2) {
            return ip2
        }
        return ip1
    }
}
