package kgl

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.apache.tomcat.jni.Local

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

    def category() {
        [
                categories: Category.list(sort: 'channel', order: 'desc')
        ]
    }

    def categoryAdd() {

        def channel = Channel.findByName(params.channelName)?:Channel.findByIsDefault(true)

        def category = new Category(
                name: params.categoryName,
                rankOnTop: null,
                enable: true,
                order: Category.countByChannel(channel) + 1,
                category: null,
                channel: channel,
                iconUrl: null
        )

        category.save flush: true

        redirect action: 'category'
    }

    def categoryUpdate() {
        [
                category: Category.get(params.id)
        ]
    }

    def categoryUpdateSave(Category category) {

        if (params.boolean('delete', false)) {
            category.delete flush: true
        }
        redirect action: 'category'
    }

    def config() {
        [
                configs: Configuration.list(sort: 'name', order: 'desc')
        ]
    }

    def configAdd() {

        def config = new Configuration(
                name: params.configName,
                content: params.configContent
        )

        config.save flush: true

        redirect action: 'config'
    }

    def configUpdate() {
        [
                config: Configuration.get(params.id)
        ]
    }

    def configUpdateSave(Configuration config) {

        if (params.boolean('delete', false)) {
            config.delete flush: true
        }

        redirect action: 'config'
    }

    def user() {
        [
                users: User.list()
        ]
    }

    def locale() {

        def group = params.group?:'messages'

        def availableLocales = []

        [
                Locale.ENGLISH,
                Locale.TRADITIONAL_CHINESE,
                Locale.SIMPLIFIED_CHINESE,
                Locale.KOREAN,
                Locale.JAPANESE,
                Locale.FRENCH
        ].each { l ->
            availableLocales << [tag: l.toLanguageTag(), display: "${l.toLanguageTag()} - ${l.displayName}"]
        }

        def locales

        locales = Localization.findAllByGroup(group).sort {it.code}.unique { it.group + '.' + it.code }

        log.info "${locales?.size()} locale messages found."
        //TODO: unique closure is not efficiency

        [
                group: group,
                groups: ['messages', 'channel', 'category'],
                availableLocales: availableLocales,
                locales: locales
        ]
    }

    def localeUpdate() {
        def locales = []

        [
                Locale.ENGLISH,
                Locale.TRADITIONAL_CHINESE,
                Locale.SIMPLIFIED_CHINESE,
                Locale.KOREAN,
                Locale.JAPANESE,
                Locale.FRENCH
        ].each { l ->
            locales << [
                    tag: l.toLanguageTag(),
                    display: "${l.displayName}",
                    locale: Localization.findByLangAndGroupAndCode(l.toLanguageTag(), params.group, params.code)
            ]
        }

        [
                code: params.code,
                group: params.group,
                locales: locales
        ]
    }

    def localeUpdateSave() {

        def group = params.group
        def code = params.code

        def langs = params.list('lang[]')
        def contents = params.list('content[]')


        if (params.boolean('delete', false)) {
            Localization.findAllByGroupAndCode(group, code).each {
                it.delete flush: true
            }
        }
        else {
            for (def i=0; i < langs.size(); i++) {
                def lang = langs[i]
                def content = contents[i]

                def locale = Localization.findOrCreateByGroupAndCodeAndLang(group, code, lang)
                locale.content = content
                locale.save flush: true
            }
        }


        redirect action: 'locale', params: [group: group]
    }

    def localeAdd() {

        def locale = new Localization(params)

        locale.save flush: true

        redirect action: 'locale'
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
