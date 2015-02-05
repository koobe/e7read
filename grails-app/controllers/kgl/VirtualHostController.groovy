package kgl

import grails.converters.JSON

class VirtualHostController {

    def index() {}

    def debug() {

        log.info "current channel in request attributes: ${request.getAttribute('channel')}"

        render VirtualHost.list() as JSON
    }
}
