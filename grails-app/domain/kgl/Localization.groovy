package kgl

/**
 * 語系, Localization a.k.a. Locale
 */
class Localization {

    /**
     * zh_TW, zh_CN, en_US
     */
    String lang

    /**
     * Group
     */
    String group

    /**
     * key
     */
    String code

    /**
     * Translation
     */
    String content

    static constraints = {
        id composite: ['lang', 'code']
        content nullable: true, blank: true
    }

    static mapping = {
        group column: '`group`'
    }
}
