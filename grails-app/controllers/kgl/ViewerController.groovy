package kgl

import grails.converters.JSON
import grails.converters.XML

/**
 * KGL HTML5 Book Viewer
 */
class ViewerController {

    def s3Service

    def index() {}

    def debug() {

//        def result = []
//        result << [files: s3Service.listObjects('koobecloudepub', 'books-2x/epub/unzip/0/0/0/00027349-daf1-4bd9-b291-1babe3ed48fa.epub/OEBPS/')]
//        render result as JSON

        render s3Service.getObject('koobecloudepub', 'books-2x/epub/unzip/0/0/1/00161d7a-ee45-4404-8bc3-8e51d0d769ab.epub/OEBPS/content.opf').text

        //render s3Service.getObject('koobecloudepub', 'books-2x/epub/unzip/0/0/0/0000f683-b28a-4ead-9dba-e39d5fcac10a.epub/OEBPS/content.opf').text

        //render s3Service.getObject('koobecloudepub', 'books-2x/epub/unzip/0/0/0/00027349-daf1-4bd9-b291-1babe3ed48fa.epub/OEBPS/package.opf').text
        //render s3Service.hasObject('koobecloudepub', 'books-2x/epub/unzip/0/0/0/00027349-daf1-4bd9-b291-1babe3ed48fa.epub/OEBPS/package.opf')
    }

    def open() {
        def pages = []

        //result << [bucket: s3Service.listBuckets()]

//        def result = []
//        result << [files: s3Service.listObjects('koobecloudepub', 'books-4x/epub/0/0/1/00163925-1a6f-4ca8-a5e2-a55ad6b331c6.epub/OEBPS/images/')]
//        render result as JSON

        //render s3Service.getObject('koobecloudepub', 'books-2x/epub/unzip/0/0/1/00161d7a-ee45-4404-8bc3-8e51d0d769ab.epub/OEBPS/contents.xml').text

        //render s3Service.getObject('koobecloudepub', 'books-2x/epub/unzip/0/0/1/00161d7a-ee45-4404-8bc3-8e51d0d769ab.epub/OEBPS/contents.xml').text

        [
                cover: s3Service.generatePresignedUrl('koobecloudepub', "books-4x/epub/0/0/1/00163925-1a6f-4ca8-a5e2-a55ad6b331c6.epub/OEBPS/images/cover.jpg"),
                pages: (1..132).collect { s3Service.generatePresignedUrl('koobecloudepub', "books-4x/epub/0/0/1/00163925-1a6f-4ca8-a5e2-a55ad6b331c6.epub/OEBPS/images/${it}.jpg") }
        ]
    }
}
