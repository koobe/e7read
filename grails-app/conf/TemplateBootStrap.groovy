import kgl.*

class TemplateBootStrap {

    def grailsApplication

    def init = { servletContext ->

        log.info "Create original templates"

        // Create Original Template

        def templates = grailsApplication.getParentContext().getResource("classpath:resources/templates").file

        log.info "Import all HTML templates"

        templates.eachFileMatch(~/.*\.html/, {
            template ->
                def baseName = template.name.replace(".html", "")

                log.info "OriginalTemplate.findOrCreateByName(${baseName})"

                def ot = OriginalTemplate.findOrCreateByName(baseName)

                ot.name = baseName
                ot.html = template.getText('UTF-8')
                ot.group = 'A'
                ot.mediaCount = 2
                ot.textCount = 2
                ot.renderType = OriginalTemplateRenderType.HTML

                log.info "Save ${ot.html.bytes.length} bytes."

                ot.save flush: true
        })

        log.info "Import all GSP templates"

        templates.eachFileMatch(~/.*\.gsp/, {
            template ->
                def baseName = template.name.replace(".gsp", "")

                log.info "OriginalTemplate.findOrCreateByName(${baseName})"

                def ot = OriginalTemplate.findOrCreateByName(baseName)

                ot.name = baseName
                ot.html = template.getText('UTF-8')
                ot.group = 'A'
                ot.mediaCount = 2
                ot.textCount = 2
                ot.renderType = OriginalTemplateRenderType.GSP

                log.info "Save ${ot.html.bytes.length} bytes."

                ot.save flush: true
        })

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
