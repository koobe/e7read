package kgl

import org.springframework.context.support.AbstractMessageSource
import java.text.MessageFormat

class DatabaseMessageSource extends AbstractMessageSource {

    def messageBundleMessageSource

    /**
     *
     * @param code
     * @param locale
     * @return
     */
    protected MessageFormat resolveCode(String code, Locale locale) {

        def group = 'messages'

        if (code.indexOf('|') >= 0) {
            group = code.substring(0, code.indexOf('|'))
            code = code.substring(code.indexOf('|') + 1)
        }

        Localization loc = Localization.findByGroupAndCodeAndLang(group, code, locale.toLanguageTag())

        if (!loc) {
            loc = Localization.findByGroupAndCodeAndLang(group, code, Locale.ENGLISH.toLanguageTag())
        }

        if (loc) {
            return new MessageFormat(loc.content, Locale.forLanguageTag(loc.lang))
        }
        else {
            return messageBundleMessageSource.resolveCode(code, locale) //new MessageFormat(code, locale)
        }
    }
}
