package kgl

import grails.plugin.springsecurity.annotation.Secured

import java.util.zip.GZIPInputStream
import java.util.zip.ZipException

@Secured(["ROLE_USER"])
class DemoController {

    def springSecurityService

    def index() {}

    def template() {

    }

    def rss() {
    }

    def rssImport() {
        def url = params.url

        if (!url) {
            redirect action: 'rss'
            return
        }

        log.info "Import RSS Feeds from the URL: ${url}"

        def rssUrl = new URL('http://www.nasa.gov/rss/dyn/image_of_the_day.rss')


        def rssText

        try {
            rssText = new GZIPInputStream(rssUrl.newInputStream(requestProperties:['Accept-Encoding': 'gzip,deflate'])).text
        }
        catch (ZipException) {
            rssText = rssUrl.getText('UTF-8')
        }

        def rss = new XmlSlurper().parseText(rssText)

        def defaultTemplate = OriginalTemplate.defaultTemplate

        if (!defaultTemplate) {
            log.warn "Missing default template."
        }

        def count = 0

        rss.channel.item.each {

            log.info "Fetch title: \"${it.title}\""

            if (Content.countByCropTitle(it.title) == 0) {

                def content = new Content(
                        fullText: it.description.text(),
                        user: springSecurityService.currentUser,
                        template: defaultTemplate,
                        cropText: it.description.text(),
                        cropTitle: it.title.text(),
                        coverUrl: it.enclosure.'@url'.text(),
                        hasPicture: true,
                        isPrivate: false,
                        isDelete: false
                )

                /*
                def s3file = new S3File(
                        owner: springSecurityService.currentUser,
                        originalFilename: '',
                        contentType: '',
                        contentLength: 0,
                        bucket: '',
                        objectKey: '',
                        resourceUrl: it.enclosure.'@url'.text(),
                        hasBeenUploaded: false,
                        isPublic: true,
                        remark: 'IMPORT-FROM-RSS'
                )
                */

                content.pictureSegments = []
                content.pictureSegments << new PictureSegment(
                        content: content,
                        dataIndex: 0,
                        originalUrl: it.enclosure.'@url'.text(),
                        thumbnailUrl: it.enclosure.'@url'.text()
                )

                content.textSegments = []
                content.textSegments << new TextSegment(
                        content: content,
                        dataIndex: 0,
                        text: it.description.text()
                )

                if (content.validate()) {

                    content.save(flush: true)

                    count ++
                }
                else {
                    log.warn content.errors
                }
            }
        }

        if (count > 0) {
            flash.message = "Successful imported ${count} contents."
        }
        else {
            flash.message = "No any changes could be import."
        }
        redirect action: 'rss'

    }
}
