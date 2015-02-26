package kgl

import grails.converters.JSON

class PageController {
	
	def s3Service

    def index() { }
	
	def get() {
		
		def bookId =  params.bookId
		def dataIndex = params.dataIndex
		
		def page = Page.findByBookAndDataIndex(Book.get(params.bookId), dataIndex as int)
		
		def dataMap = [:]
		
		if (page) {
			def imageUrl = s3Service.generatePresignedUrl(page.bucket, page.imageKey)
			def thumbnailUrl = s3Service.generatePresignedUrl(page.bucket, page.thumbnailKey)
			
			dataMap.id = page.id
			dataMap.bookId = bookId
			dataMap.dataIndex = dataIndex
			dataMap.imageUrl = imageUrl
			dataMap.thumbnailUrl = thumbnailUrl
		}
		
		render dataMap as JSON
	}
}
