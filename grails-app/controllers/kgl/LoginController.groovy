package kgl

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils

class LoginController {

    //final String ___MAIN_FACEBOOK_AUTH_DOMAIN_SERVER___ = 'http://dev.e7read.com:8080'

    /**
     * Dependency injection for the authenticationTrustResolver.
     */
    def authenticationTrustResolver

    /**
     * Dependency injection for the springSecurityService.
     */
    def springSecurityService

    def index() {}

    // Custom Auth Page
    def auth() {
        def config = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            redirect uri: config.successHandler.defaultTargetUrl
            return
        }

        String view = 'auth'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"

        makeSessionData()

        render view: view, model: [
                postUrl: postUrl,
                rememberMeParameter: config.rememberMe.parameter,
                isAdmin: params.getBoolean('isAdmin'),
                redirect: session['sso_redirect'],
                ssoUrl: "${grailsApplication.config.login.sso}?redirect=${session['sso_redirect']}&token=${session['sso_token']}&_t=${new Date().time}"
        ]
    }

    def debug() {
        def result = [:]

        result << [
                attrs: session.attributeNames.collect {it},
                //SPRING_SECURITY_CONTEXT: session['SPRING_SECURITY_CONTEXT']
                'facebook:oasAccessToken': session['facebook:oasAccessToken'],
                'redirect_logged': session['redirect_logged'],
                'oauthPluginRedirectHash': session['oauthPluginRedirectHash']
        ]

        render result as JSON
    }

    def oauth() {

    }

    def sso() {
        def result = [:]

        result << [redirect: params.redirect, token: params.token]

        //makeSessionData()

        session['sso_redirect'] = params.redirect
        session['sso_token'] = params.token

        render result as JSON
    }

    def ssoCallback() {

        log.info "sso callback ${session['sso_token']}"


        def user = User.findBySsoToken(session['sso_token'])

        if (user) {
            SpringSecurityUtils.reauthenticate(user.username, user.password)
        }

        redirect uri: '/'
    }

    private makeSessionData() {
//        if (request.getHeader('referer')) {
//            session['redirect_logged'] = request.getHeader('referer')
//        }
//        else {
//            session['redirect_logged'] = "${request.scheme}://${request.serverName}:${request.serverPort}/"
//        }

        session['sso_redirect'] = "${request.scheme}://${request.serverName}:${request.serverPort}/login/ssoCallback?SSO_FB_TOKEN=[SSO_FB_TOKEN]"
        session['sso_token'] = UUID.randomUUID().toString()

        //session['redirect2'] = "${request.scheme}://${request.serverName}:${request.serverPort}/"
    }
}
