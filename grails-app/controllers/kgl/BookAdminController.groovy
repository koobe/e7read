package kgl


class BookAdminController {
	
	def s3Service

    def index() { 
	}
	
	def publisherList() {
		
	}
	
	def newBookList() {
		
		def max = params.max? params.max: 10
		def offset = params.offset? params.offset: 0
		
		def bookCount = Book.countByIsCheckedAndIsDeleteAndFinishedUpload(false, false, true)
		
		def books = Book.findAllByIsCheckedAndIsDeleteAndFinishedUpload(false, false, true, 
			[max: max, offset: offset, sort: "dateCreated", order: "desc"])
		
		books.each { book ->
			if (book.pages?.getAt(0)) {
				def coverUrl = s3Service.generatePresignedUrl(
					book.pages.getAt(0).bucket, book.pages.getAt(0).thumbnailKey)
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
		
		def max = params.max? params.max: 10
		def offset = params.offset? params.offset: 0
		
		def bookCount = Book.countByIsCheckedAndIsDeleteAndFinishedUpload(true, false, true)
		
		def books = Book.findAllByIsCheckedAndIsDeleteAndFinishedUpload(true, false, true,
			[max: max, offset: offset, sort: "dateCreated", order: "desc"])
		
		books.each { book ->
			if (book.pages?.getAt(0)) {
				def coverUrl = s3Service.generatePresignedUrl(
					book.pages.getAt(0).bucket, book.pages.getAt(0).thumbnailKey)
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
		
		[book: book, publishers: publishers, params: params]
	}
	
}
