package kgl

import grails.converters.JSON

class SearchController {

    def index() {
        def result = Content.search(params.q)

        render result as JSON
    }
}
