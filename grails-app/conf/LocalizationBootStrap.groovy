import kgl.Localization

class LocalizationBootStrap {

    def grailsApplication

    def init = { servletContext ->

        readPropertiesToDatabase(Locale.ENGLISH)
        readPropertiesToDatabase(Locale.TRADITIONAL_CHINESE)
        readPropertiesToDatabase(Locale.SIMPLIFIED_CHINESE)
        readPropertiesToDatabase(Locale.JAPANESE)
        readPropertiesToDatabase(Locale.KOREAN)
        readPropertiesToDatabase(Locale.FRENCH)
    }

    def destroy = {
    }

    private readPropertiesToDatabase(Locale locale) {
        Properties props = new Properties()

        def propsFile = getPropsFile(locale)

        if (!propsFile || !propsFile.exists()) {
            return;
        }

        props.load(propsFile.newInputStream())

        if (!locale) {
            locale = Locale.ENGLISH
        }

        props.keySet().each { code ->
            def content = props.get(code)

            def loc = Localization.findByGroupAndCodeAndLang('messages', code, locale.toLanguageTag())

            if (!loc) {

                def group = 'messages'

                if (code.indexOf('|') >= 0) {
                    group = code.substring(0, code.indexOf('|'))
                    code = code.substring(code.indexOf('|') + 1)
                }

                loc = new Localization(group: group, code: code, lang: locale.toLanguageTag(), content: content)
                loc.save flush: true
            }
        }

    }

    private getPropsFile(Locale locale) {
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
