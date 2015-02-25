package kgl


class BookAdminController {
	
	def s3Service
	def searchService

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
			publishers: publishers
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
		
			def pages = Content.executeQuery(hql, [bookId: book.id], [max: 1, offset: 0])
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
			
			def pages = Content.executeQuery(hql, [bookId: book.id], [max: 1, offset: 0])
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
		
		def books = []
		books.push(book)
				
		[
			books: books,
			chapter: chapter
		]
	}
	
	def pageSelector() {
		
		def bookId = params.bookId
		
		def book = Book.get(bookId)
		
		def pages = Page.findAllByBook(book, [sort: 'dataIndex', order: 'asc'])
		
	}
}
