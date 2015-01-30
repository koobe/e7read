package kgl

import grails.converters.JSON

class BookController {

    private final static String UTF8_BOM = "\uFEFF"

    def s3Service

    def index() {}


    def legacy() {
        [legacies: Legacy.list()]
    }

    /**
     * Import KGL B2B EPUB
     */
    def legacyImport() {
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

        String[] tokens = file.split('/')
        def key = tokens[tokens.size()-1].replace('.epub', '')

        def legacy = Legacy.findByKey(key)

        if (!legacy) {


            def opf = s3Service.getObject('koobecloudepub', "${file}OEBPS/content.opf").text

            // remove BOM
            if (opf.startsWith(UTF8_BOM)) {
                opf = opf.substring(1)
            }

            def xml = new XmlSlurper().parseText(opf)

            xml.declareNamespace(dc: "http://purl.org/dc/elements/1.1/")

            legacy = new Legacy()
            legacy.key = key
            legacy.s3key = file
            legacy.metadata = ''
            legacy.opf = ''
            legacy.title = xml.metadata.'dc:title'
            legacy.creator = xml.metadata.'dc:creator'
            legacy.contributor = xml.metadata.'dc:contributor'
            legacy.date = xml.metadata.'dc:date'
            legacy.language = xml.metadata.'dc:language'
            legacy.subject = xml.metadata.'dc:subject'
            legacy.description = xml.metadata.'dc:description'

            legacy.save flush: true
        }

        result << [legacy: legacy]

        result << [message: '']

        render result as JSON
    }
}
