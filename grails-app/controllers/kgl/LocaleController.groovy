package kgl

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class LocaleController {

    def index() {}

    @Secured(["ROLE_USER"])
    def debug() {
        render Localization.list() as JSON
    }
}
