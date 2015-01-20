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

        def result = []

        render result as JSON
    }

    def open() {
        def pages = []

        //result << [bucket: s3Service.listBuckets()]

        //result << [files: s3Service.listObjects('koobecloudepub', 'books-2x/epub/unzip/0/0/1/00161d7a-ee45-4404-8bc3-8e51d0d769ab.epub/OEBPS/')]
        //render result as JSON

        //render s3Service.getObject('koobecloudepub', 'books-2x/epub/unzip/0/0/1/00161d7a-ee45-4404-8bc3-8e51d0d769ab.epub/OEBPS/contents.xml').text

        //render s3Service.getObject('koobecloudepub', 'books-2x/epub/unzip/0/0/1/00161d7a-ee45-4404-8bc3-8e51d0d769ab.epub/OEBPS/contents.xml').text

        [
                cover: s3Service.generatePresignedUrl('koobecloudepub', "books-2x/epub/unzip/0/0/1/00161d7a-ee45-4404-8bc3-8e51d0d769ab.epub/OEBPS/images/cover.jpg"),
                pages: (1..196).collect { s3Service.generatePresignedUrl('koobecloudepub', "books-2x/epub/unzip/0/0/1/00161d7a-ee45-4404-8bc3-8e51d0d769ab.epub/OEBPS/images/${it}.jpg") }
        ]
    }
}
