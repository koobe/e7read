package kgl

import grails.plugin.springsecurity.annotation.Secured

import java.util.zip.GZIPInputStream

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
        def rssText = new GZIPInputStream(rssUrl.newInputStream(requestProperties:['Accept-Encoding': 'gzip,deflate'])).text

        def rss = new XmlSlurper().parseText(rssText)

        def count = 0

        rss.channel.item.each {

            log.info "Fetch title: \"${it.title}\""

            if (Content.countByCropTitle(it.title) == 0) {

                def content = new Content(
                        fullText: it.description.text(),
                        user: springSecurityService.currentUser,
                        originalTemplate: OriginalTemplate.findByName('default'),
                        cropText: it.description.text(),
                        cropTitle: it.title.text(),
                        coverUrl: it.enclosure.'@url'.text(),
                        hasPicture: true,
                        isPrivate: false,
                        isDelete: false
                )

                content.validate()
                log.info(content.errors)

                count += content.save(flush: true)?1:0
            }
        }

        flash.message = "Successful imported ${count} contents."
        redirect action: 'rss'
    }
}
