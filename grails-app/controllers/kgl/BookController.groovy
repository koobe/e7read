package kgl

import grails.converters.JSON

class BookController {

    def s3Service

    def index() {}

    /**
     * List legacy KGL B2B books
     */
    def legacy() {
        def result = []
        def files = []

        //def hex = (0..15).collect { Integer.toHexString(it) }

        s3Service.listObjects('koobecloudepub', 'books-2x/epub/unzip', '.epub/')?.each {
            files << it
        }

        s3Service.listObjects('koobecloudepub', 'books-4x/epub', '.epub/')?.each {
            files << it
        }

        [
                files: files
        ]
    }

    def legacyFetchXML() {
        def result = []
        def file = params.file

        result << [file: file]

        result << [path: "${file}OEBPS/contents.xml"]

        def content = s3Service.getObject('koobecloudepub', "${file}OEBPS/content.opf").text

        def legacy = new Legacy()
        legacy.s3key = file
        legacy.name = ''
        legacy.description = ''

        def xml = new XmlSlurper().parseText(content)

        log.info xml.metadata

        result << [content: content]

        result << [message: '']

        render result as JSON
    }
}
