package kgl

import grails.transaction.Transactional

@Transactional
class LocaleService {

    def grailsApplication

    def readPropertiesToDatabase(Locale locale, boolean rewrite = false) {

        log.info "Load locale message file for ${locale.toLanguageTag()}"

        Properties props = new Properties()

        def propsFile = getPropsFile(locale)

        if (!propsFile || !propsFile.exists()) {
            return;
        }

        props.load(propsFile.newReader('UTF-8'))

        if (!locale) {
            locale = Locale.ENGLISH
        }

        props.keySet().each { code ->
            def content = props.get(code)

            def loc = Localization.findByGroupAndCodeAndLang('messages', code, locale.toLanguageTag())

            if (!loc || rewrite) {

                def group = 'messages'

                if (code.indexOf('|') >= 0) {
                    group = code.substring(0, code.indexOf('|'))
                    code = code.substring(code.indexOf('|') + 1)
                }

                log.info "append locale: ${group}|${code}=${content}"

				if (loc) {
					loc.group = group
					loc.code = code
					loc.lang = locale.toLanguageTag()
					loc.content = content
				} else {
					loc = new Localization(group: group, code: code, lang: locale.toLanguageTag(), content: content)
				}
                
                loc.save flush: true
            }
        }

    }

    private File getPropsFile(Locale locale) {
        def fileName

        if (!locale || locale.equals(Locale.ENGLISH)) {
            fileName = "messages.properties"
        }
        else {
            fileName = "messages_${locale.toLanguageTag().replace('-', '_')}.properties"
        }

        def file = null

        try {
            file = grailsApplication.parentContext.getResource("classpath:grails-app/i18n/${fileName}")?.file
        }
        catch (e) {

        }

        return file
    }
}
