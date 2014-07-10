package kgl

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_USER"])
class EditorController {

    def index() {}
}
