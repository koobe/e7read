package kgl

import com.amazonaws.services.s3.model.AmazonS3Exception
import grails.converters.JSON

class BookController {

    def s3Service

    def index() {}

	def update(Book book) {
		if (book) {
			
			def publishers = Publisher.list()
			
			if (book.pages?.getAt(0)) {
				def coverUrl = s3Service.generatePresignedUrl(
					book.pages.getAt(0).bucket, book.pages.getAt(0).thumbnailKey)
				book.coverUrl = coverUrl
			}
			
			if (book.hasErrors()) {
				respond book.errors, view: '/bookAdmin/book', model: [book: book, publishers: publishers]
				return
			}
			
			book.save flush:true
			
			if (book.isDelete) {
				
				def redirectAction = ""
				if (session?.bookAdminNavigation?.prevAction) {
					redirectAction = '/bookAdmin/' + session?.bookAdminNavigation?.prevAction
				} else {
					redirectAction = '/bookAdmin/index'
				}
				
				def redirectParams = [:]
				session?.bookAdminNavigation?.params.each { key, value ->
					if (value) {
						redirectParams[key] = value
					}
				}
				
				redirect uri: redirectAction, params: redirectParams
			} else {
				respond book, view: '/bookAdmin/book', model: [book: book, publishers: publishers, success: true]
			}
			
		}
	}

	def debug() {
		render Book.list() as JSON
	}
}
