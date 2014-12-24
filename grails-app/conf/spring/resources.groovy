// Place your Spring DSL code here
beans = {
    userDetailsService(kgl.MyUserDetailsService)
    messageSource(kgl.DatabaseMessageSource) {
        messageBundleMessageSource = ref("messageBundleMessageSource")
    }
    messageBundleMessageSource(org.codehaus.groovy.grails.context.support.PluginAwareResourceBundleMessageSource) {
        basenames = "WEB-INF/grails-app/i18n/messages"
    }
}
