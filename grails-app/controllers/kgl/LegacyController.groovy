package kgl

import grails.converters.JSON
import grails.converters.XML

class LegacyController {

    def s3Service

    def index() {}

    def cover(Legacy legacy) {
        redirect uri: s3Service.generatePresignedUrl('koobecloudepub', "${legacy.s3key}OEBPS/${legacy.coverKey}")
    }

    def opf(Legacy legacy) {
        response.contentType = 'text/xml'
        response.characterEncoding = 'UTF-8'
        response << legacy.opf
    }

    def debug() {
        render Legacy.list() as JSON
    }

}
