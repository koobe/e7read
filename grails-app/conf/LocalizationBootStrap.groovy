import kgl.Localization

class LocalizationBootStrap {

    def grailsApplication

    def localeService

    def init = { servletContext ->

		if (grailsApplication.config.grails.application.bootstrap_meta) {
            localeService.readPropertiesToDatabase(Locale.ENGLISH)
            localeService.readPropertiesToDatabase(Locale.TRADITIONAL_CHINESE)
            localeService.readPropertiesToDatabase(Locale.SIMPLIFIED_CHINESE)
            localeService.readPropertiesToDatabase(Locale.JAPANESE)
            localeService.readPropertiesToDatabase(Locale.KOREAN)
            localeService.readPropertiesToDatabase(Locale.FRENCH)
		}
        
    }

    def destroy = {
    }
}
