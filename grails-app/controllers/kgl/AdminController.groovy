package kgl

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Secured(["ROLE_ADMIN"])
class AdminController {

    def grailsLinkGenerator

    def s3Service

    def springSecurityService

    def index() {
    }

    def dashboard() {

    }

    def channel() {
        [
                channels: Channel.list()
        ]
    }

    def channelAdd() {
        def channel = new Channel(
                name: params.channelName,
                isDefault: false,
                logoImg: "/assets/logo_e7read.png",
                smallLogoUrl: "/assets/trans_logo_e7read.png",
                canAnonymous: true,
                themeType: "article",
                showInPanel: true,
                order: Channel.count(),
                iconUrl: grailsLinkGenerator.asset(src: 'e7logo-marker-icon1-32x32.png', absolute: true)
        )

        channel.save flush: true

        redirect action: 'channel'
    }

    def channelUpdate() {
        [
                channel: Channel.get(params.id)
        ]
    }

    def channelUpdateSave(Channel channel) {

        if (params.boolean('delete', false)) {
            channel.delete flush: true
        }
        redirect action: 'channel'
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
