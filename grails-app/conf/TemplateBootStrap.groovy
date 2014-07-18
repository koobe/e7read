import kgl.*

class TemplateBootStrap {

    def grailsApplication

    def templateService

    def init = { servletContext ->

        log.info "Load all built-in templates (TemplateBootStrap)"

        templateService.loadBuiltIn()

        // Create Original Template

//        if (OriginalTemplate.count() == 0) {
//            def template1 = new OriginalTemplate()
//            template1.name = "default"
//            template1.html = "<p>text</p>"
//            template1.group = "A"
//            template1.mediaCount = 2
//            template1.textCount = 2
//            template1.save flush: true
//        }



    }
    def destroy = {
    }
}
