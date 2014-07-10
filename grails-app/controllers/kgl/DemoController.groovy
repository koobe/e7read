package kgl

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_USER"])
class DemoController {

    def index() {}

    def template() {

    }
}
