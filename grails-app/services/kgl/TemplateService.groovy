package kgl

import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.pages.GroovyPagesTemplateEngine
import org.jsoup.Jsoup

@Transactional
class TemplateService {

    def grailsApplication

    GroovyPagesTemplateEngine groovyPagesTemplateEngine

    String render(Content content) {
        return render(content, content?.template)
    }

    String render(Content content, OriginalTemplate template) {
        if (!content) {
            log.warn "Could not render a null(or empty) content."
            return ""
        }

        if (!template) {
            log.warn "Content ${content.id} has no original template."
            return content.fullText.replaceAll("\n\n", "<br/><br/>")
        }

        if (template.renderType == OriginalTemplateRenderType.HTML) {
            return renderInJsoup(content, template)
        }

        if (template.renderType == OriginalTemplateRenderType.GSP) {
            return renderInGSP(content, template)
        }
    }

    private String renderInJsoup(Content content, OriginalTemplate template) {
        def fullText = content.fullText?.replace("\r", "")

        def texts = fullText?.split("\n\n")

        def doc = Jsoup.parse(template?.html)

        int index = 0

        println texts.length

        texts.each {
            text ->
                doc.select(".text-segment[data-index=${index++}]").html(text?.encodeAsHTML())
        }

        index = 0

        content.pictureSegments.each {
            pictureSegment ->
                doc.select(".picture-segment[data-index=${index++}]").attr("src", pictureSegment.originalUrl)
        }

        doc.select(".crop-title").html(content.cropTitle)
        doc.select(".crop-text").html(content.cropText)

        return doc.html()
    }

    private String renderInGSP(Content content, OriginalTemplate template) {

        def fullText = content.fullText?.replace("\r", "")

        def texts = fullText?.split("\n\n")

        def textSegment = []

        texts.each {
            textSegment << it
        }

        def writer = new StringWriter()

        groovyPagesTemplateEngine
                .createTemplate(template?.html, 'output')?.make([title: 'test title 1', textSegment: textSegment])?.writeTo(writer)

        return writer.toString()
    }

    void loadBuiltIn() {
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

                log.info ot.save(flush: true)
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

                log.info ot.save(flush: true)
        })
    }

}
