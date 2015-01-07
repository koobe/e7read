package kgl

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class LocaleController {

    def index() {}

    @Secured(["ROLE_USER"])
    def debug() {
        render Localization.list() as JSON
    }

    def json() {
        // todo: from resultset to json

        def group = params.get('group', 'messages')

        def lang = params.get('lang', Locale.default.toLanguageTag())


        def bundle = params.bundle


        if (bundle?.indexOf('_') >= 0) {
            def tokens = params.bundle.split('_')
            group = tokens[0]
            lang = tokens[1]
        }
        else if (bundle) {
            group = bundle
        }

        def result = [
                'group' : group,
                'lang' : lang
        ]

        Localization.findAllByGroupAndLang(group, Locale.ENGLISH.toLanguageTag()).each {
            result[it.code] = it.content
        }

        Localization.findAllByGroupAndLang(group, lang).each {
            result[it.code] = it.content
        }

        render result as JSON
    }
}
