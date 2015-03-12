package kgl

class Legacy {

    def s3Service

    String bucket

    String key

    String s3key

    String metadata

    String title

    String description

    String opf

    String creator

    String contributor

    String date

    String language

    String subject

    String publisher

    String coverKey

    String imageItems

    Book book

    Date dateCreated
    Date lastUpdated

    static mapping = {
        opf type: 'text'
        imageItems type: 'text'

        //date column: '`date`'
        key column: '`key`'
    }

    static constraints = {
        description maxSize: 10 * 1024
        coverKey nullable: true
        imageItems nullable: true
        book nullable: true
    }

    static transients = ['s3Service', 'coverUrl']

    URL getCoverUrl() {
        s3Service.generatePresignedUrl(bucket, "${s3key}OEBPS/${coverKey}")
    }

    def createBook() {
        book = new Book()
        book.name = title
        book.author = creator
        //book.datePublish = date
        book.coverUrl = getCoverUrl().toString()
        book.bucket = bucket
        book.isChecked = false
        book.isDelete = false

        book.save flush: true
    }

    /**
     * Add pages after book object created
     */
    def addPage(String imageKey, int dataIndex) {

        def page = new Page()

        page.bucket = bucket
        page.book = book
        page.imageKey = imageKey
        page.dataIndex = dataIndex

        page.save flush: true

        if (page.hasErrors()) {
            log.warn(page.errors)
        }

        if (!book.pages) {
            book.pages = []
        }

        book.pages << page

        book.save flush: true
    }
}
