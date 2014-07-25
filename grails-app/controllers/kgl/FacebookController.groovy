package kgl

import grails.converters.JSON
import org.scribe.model.Token

class FacebookController {

    def oauthService
    def grailsApplication
    def springSecurityService

    private final static String FACEBOOK_API_URL = "https://graph.facebook.com/me"

    def index() {}

    /**
     * Example: Facebook Login for the Web with the JavaScript SDK
     * https://developers.facebook.com/docs/facebook-login/login-flow-for-web/v2.0
     */
    def example1() {}

    def success() {

        Token token = (Token) session[oauthService.findSessionKeyForAccessToken('facebook')]

        def response = oauthService.getFacebookResource(token, FACEBOOK_API_URL)
        def resource = JSON.parse(response.body)

        // Sample
        log.info(resource)

        User user = User.findByAuthTypeAndFacebookId("FACEBOOK", resource.id)

        if (!user) {
            log.info("Create a new user domain class from facebook account data")

            def userRole = Role.findOrSaveByAuthority('ROLE_USER')

            user = new User(
                    fullName: resource.name,
                    email: resource.email,
                    username: resource.username?:"facebook_${resource.id}",
                    password: new Date().time,
                    authType: 'FACEBOOK',
                    facebookId: resource.id,
                    facebookUrl: resource.link,
                    enabled: true
            )
            user.save(failOnError: true, flush: true)

            UserRole.create(user, userRole)
        }

        springSecurityService.reauthenticate user.username

        redirect uri: "/"
    }
}
