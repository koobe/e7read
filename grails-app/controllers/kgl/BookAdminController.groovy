package kgl

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class BookAdminController {
	
	def s3Service
	def searchService
	def springSecurityService
	def categoryService

    def index() { 
	}
	
	def publisherList() {
		
		def q = params.q
		def max = params.max? params.max: 10
		params.size = max
		def offset = params.offset? params.offset: 0
		
		def publishers
		
		publishers = Publisher.list(max: max, offset: offset, sort: "name", order: "asc")
		
		[
			publishers: publishers,
			publisherCount: Publisher.count(),
			params: params
		]
	}
	
	def publisher() {
		
		def publisher
		
		if (params.id) {
			publisher = Publisher.get(params.id)
		} else {
			publisher = new Publisher()
		}
		
		[
			publisher: publisher
		]
	}
	
	def newBookList() {
		
		def q = params.q
		def max = params.max? params.max: 10
		params.size = max
		def offset = params.offset? params.offset: 0
		
		def bookCount
		def books
		
		if (q) {
			
			def searchResult = searchService.searchBook(q, params)
			bookCount = searchResult.total
			books = searchResult.searchResults
			
		} else {
			bookCount = Book.countByIsCheckedAndIsDeleteAndFinishedUpload(false, false, true)
			books = Book.findAllByIsCheckedAndIsDeleteAndFinishedUpload(false, false, true,
				[max: max, offset: offset, sort: "dateCreated", order: "desc"])
		}
		
		books.each { book ->
			
			def hql = """
				select page from Page as page where page.book.id = :bookId order by dataIndex
			"""
		
			def pages = Page.executeQuery(hql, [bookId: book.id], [max: 1, offset: 0])
			if (pages.size() == 1) {
				def page = pages.getAt(0)
				def coverUrl = s3Service.generatePresignedUrl(page.bucket, page.thumbnailKey)
				book.coverUrl = coverUrl
			}
		}
		
		def bookAdminNavigation = [:]
		bookAdminNavigation.prevAction = 'newBookList'
		bookAdminNavigation.params = params
		session.bookAdminNavigation = bookAdminNavigation
		
		[
			books: books,
			bookCount: bookCount,
			params: params
		]
	}
	
	def bookList() {
				
		def q = params.q
		def max = params.max? params.max: 10
		params.size = max
		def offset = params.offset? params.offset: 0
		
		def bookCount
		def books
		
		if (q) {
			
			def searchResult = searchService.searchBook(q, params)
			bookCount = searchResult.total
			books = searchResult.searchResults
			
		} else {
			bookCount = Book.countByIsCheckedAndIsDeleteAndFinishedUpload(true, false, true)
			books = Book.findAllByIsCheckedAndIsDeleteAndFinishedUpload(true, false, true,
				[max: max, offset: offset, sort: "dateCreated", order: "desc"])
		}
		
		books.each { book ->
			
			def hql = """
				select page from Page as page where page.book.id = :bookId order by dataIndex
			"""
			
			def pages = Page.executeQuery(hql, [bookId: book.id], [max: 1, offset: 0])
			if (pages.size() == 1) {
				def page = pages.getAt(0)
				def coverUrl = s3Service.generatePresignedUrl(page.bucket, page.thumbnailKey)
				book.coverUrl = coverUrl
			}
		}
		
		def bookAdminNavigation = [:]
		bookAdminNavigation.prevAction = 'bookList'
		bookAdminNavigation.params = params
		session.bookAdminNavigation = bookAdminNavigation
		
		[
			books: books,
			bookCount: bookCount,
			params: params
		]
		
	}
	
	def book() {
		
		def book = Book.get(params.id)
		def publishers = Publisher.list()
		
		if (book.pages?.getAt(0)) {
			def coverUrl = s3Service.generatePresignedUrl(
				book.pages.getAt(0).bucket, book.pages.getAt(0).thumbnailKey)
			book.coverUrl = coverUrl
		}
		
		[
			book: book, 
			publishers: publishers, 
			params: params
		]
	}
	
	def chapterList() {
		
		def book = Book.get(params.id)
		
		def chapters = Chapter.findAllByBook(book, [sort: "dataIndex", order: "asc"])
		
		[
			book: book,
			chapters: chapters,
			params: params			
		]
	}
	
	def chapter() {
		
		def bookId = params.bookId
		def chapterId = params.id
		
		def book
		def chapter
		
		if (bookId) {
			book = Book.get(bookId)
		}
		if (chapterId) {
			chapter = Chapter.get(chapterId)
		} else {
			chapter = new Chapter()
			chapter.book = book
		}
		
		if (chapter.pageStart) {
			def imageUrl = s3Service.generatePresignedUrl(chapter.pageStart.bucket, chapter.pageStart.imageKey)
			def thumbnailUrl = s3Service.generatePresignedUrl(chapter.pageStart.bucket, chapter.pageStart.thumbnailKey)
			chapter.pageStart.imageUrl = imageUrl
			chapter.pageStart.thumbnailUrl = thumbnailUrl
		}
		
		if (chapter.pageEnd) {
			def imageUrl = s3Service.generatePresignedUrl(chapter.pageEnd.bucket, chapter.pageEnd.imageKey)
			def thumbnailUrl = s3Service.generatePresignedUrl(chapter.pageEnd.bucket, chapter.pageEnd.thumbnailKey)
			chapter.pageEnd.imageUrl = imageUrl
			chapter.pageEnd.thumbnailUrl = thumbnailUrl
		}
		
		def books = []
		books.push(book)
				
		[
			books: books,
			chapter: chapter
		]
	}
	
	def distribute() {
		
		def bookId = params.id
		def book
		def contents
		
		if (bookId) {
			book = Book.get(bookId)
			
			String hql = """
				select content from Content as content 
				where content.type = :type and content.bookContentAttribute.book.id = :bookId 
				order by dateCreated
			"""
			contents = Content.executeQuery(hql, [bookId: bookId, type: 'EBOOK'])
		}
		
		[
			categories: categoryService.list(grailsApplication.config.grails.application.default_channel),
			book: book,
			contents: contents
		]
	}
	
	def distributionList() {
		
		def q = params.q
		def max = params.max? params.max: 10
		params.size = max
		def offset = params.offset? params.offset: 0
		
		def contentCount = 0
		def contents = []
		
		if (q) {
			
			String channelName = params.channel?: grailsApplication.config.grails.application.default_channel
			params.type = 'EBOOK'
			
			def searchResult = searchService.searchContent(channelName, null, q, null, 50000, params)
			contentCount = searchResult.total
			contents = searchResult.searchResults
		} else {
			contentCount = Content.countByType('EBOOK')
			contents = Content.findAllByType('EBOOK', 
				[max: max, offset: offset, sort: "dateCreated", order: "desc"])
		}
		
		[
			contents: contents,
			contentCount: contentCount,
			params: params
		]
		
	}
}
