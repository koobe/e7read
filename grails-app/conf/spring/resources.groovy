// Place your Spring DSL code here
beans = {
    userDetailsService(kgl.MyUserDetailsService)
    messageSource(kgl.DatabaseMessageSource)
}
