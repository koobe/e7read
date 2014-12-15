package kgl

import org.springframework.context.support.AbstractMessageSource
import java.text.MessageFormat

class DatabaseMessageSource extends AbstractMessageSource {

    /**
     *
     * @param code
     * @param locale
     * @return
     */
    protected MessageFormat resolveCode(String code, Locale locale) {

        Localization loc = Localization.findByCodeAndLang(code, locale.toLanguageTag())

        if (loc) {
            return new MessageFormat(loc.content, Locale.forLanguageTag(loc.lang))
        }
        else {
            return new MessageFormat(code, locale)
        }
    }
}
