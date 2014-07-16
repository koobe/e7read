package kgl

import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.pages.GroovyPagesTemplateEngine
import org.jsoup.Jsoup

@Transactional
class TemplateService {

    GroovyPagesTemplateEngine groovyPagesTemplateEngine

    def render(Content content) {

        if (!content) {
            log.warn "Could not render a null(or empty) content."
            return null
        }

        if (!content.originalTemplate) {
            log.warn "Content ${content.id} has no original template."
            return null
        }

        if (content.originalTemplate.type == OriginalTemplateType.HTML) {
            return renderInJsoup(content)
        }
        else if (content.originalTemplate.type == OriginalTemplateType.GSP) {
            return renderInGSP(content)
        }
    }

    private String renderInJsoup(content) {
        def fullText = content.fullText?.replace("\r", "")

        def texts = fullText?.split("\n\n")

        def doc = Jsoup.parse(content.originalTemplate?.html)

        int index = 0

        println texts.length

        texts.each {
            text ->

                //println text

                doc.select(".text-segment[data-index=${index}]").html(text?.encodeAsHTML())

                index ++
        }

        return doc.html()
    }

    private String renderInGSP(Content content) {

        def fullText = content.fullText?.replace("\r", "")

        def texts = fullText?.split("\n\n")

        def textSegment = []

        texts.each {
            textSegment << it
        }

        def writer = new StringWriter()

        groovyPagesTemplateEngine
                .createTemplate(content.originalTemplate?.html, 'output')?.make([title: 'test title 1', textSegment: textSegment])?.writeTo(writer)

        return writer.toString()
    }
}
