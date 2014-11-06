package kgl

import grails.converters.JSON

import org.grails.plugins.elasticsearch.ElasticSearchService

class SearchController {

	ElasticSearchService elasticSearchService
	SearchService searchService

	def index() {
		def result = Content.search(params.q)

		render result as JSON
	}

	def searchContent() {
		
		render searchService.searchContent(params) as JSON
	}

}
