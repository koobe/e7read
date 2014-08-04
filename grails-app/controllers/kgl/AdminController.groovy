package kgl

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Secured(["ROLE_ADMIN"])
class AdminController {

    def s3Service

    def springSecurityService

    def index() {
    }

    def coverFiles() {
        [
                files: S3File.findAllByRemark('DEFAULT-COVER-IMAGE')
        ]
    }

    @Transactional
    def coverFilesUploadSave() {

        log.info "${params.list('file')}"
        params.list('file').each { file ->

            if (!file.isEmpty()) {

                S3File s3file

                s3file = s3Service.upload(
                        springSecurityService.currentUser,
                        file,
                        file.inputStream,
                        true,
                        'DEFAULT-COVER-IMAGE'
                )

                log.info 'S3File id: ' + s3file.id
                log.info 'S3File object key: ' + s3file.objectKey
                log.info 'S3File url: ' + s3file.url
            }
        }

        redirect action: 'coverFiles'
    }
}
