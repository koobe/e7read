package kgl

import grails.transaction.Transactional
import grails.util.Environment
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
            template = OriginalTemplate.findByName("default")
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

        content.textSegments?.each {
            textSegments ->
                doc.select("p.text-segment[data-index=${index++}]").html(textSegments.text?.encodeAsHTML())
        }

        index = 0

        content.pictureSegments?.each {
            pictureSegment ->
                doc.select("img.picture-segment[data-index=${index++}]").attr("src", pictureSegment.originalUrl)
        }

        index = 0

        content.pictureSegments?.each {
            pictureSegment ->
                def elm = doc.select("div.picture-segment[data-index=${index++}]")
                if (elm.size() > 0) {
                    def styleSettings = elm.attr("style")
                    if (styleSettings) {
                        styleSettings += ";"
                    }
                    styleSettings += "background-image:url(${pictureSegment.originalUrl})"
                    elm.attr("style", styleSettings)
                }
        }

        doc.select(".crop-title").html(content.cropTitle)
        doc.select(".crop-text").html(content.cropText)

        return doc.html()
    }

    private String renderInGSP(Content content, OriginalTemplate template) {

//        def fullText = content.fullText?.replace("\r", "")
//        def texts = fullText?.split("\n\n")
//        def textSegment = []
//        texts.each {
//            textSegment << it
//        }

        def writer = new StringWriter()

        groovyPagesTemplateEngine
                .createTemplate(template?.html, template?.name)?.make([content: content])?.writeTo(writer)

        return writer.toString()
    }

    void loadBuiltIn() {
        def templates = grailsApplication.getParentContext().getResource("classpath:resources/templates").file

        // Load from project source directory in DEV mode
        Environment.executeForCurrentEnvironment {
            development {
                if (templates.absolutePath.contains("target/work/resources")) {
                    def srcPath = new File(templates.absolutePath.replace("target/work/resources", "grails-app/conf"))

                    if (srcPath.exists() && srcPath.isDirectory()) {
                        templates = srcPath
                    }
                }
            }
        }

        log.info "Import all HTML templates"

        templates.eachFileMatch(~/.*\.html/, {
            file ->
                log.info "Processing ${file.absolutePath}"

                def baseName = file.name.replace(".html", "")

                saveTemplate(baseName, file.getText('UTF-8'), 'A', 2, 2, OriginalTemplateRenderType.HTML)
        })

        log.info "Import all GSP templates"

        templates.eachFileMatch(~/.*\.gsp/, {
            file ->
                log.info "Processing ${file.absolutePath}"

                def baseName = file.name.replace(".gsp", "")

                saveTemplate(baseName, file.getText('UTF-8'), 'A', 2, 2, OriginalTemplateRenderType.GSP)
        })
    }

    private void saveTemplate(String baseName, String html, String group,
                              int mediaCount, int textCount, OriginalTemplateRenderType type) {

        log.info "OriginalTemplate.findOrCreateByName(${baseName})"

        def ot = OriginalTemplate.findOrCreateByName(baseName)

        ot.name = baseName
        ot.html = html
        ot.group = group
        ot.mediaCount = mediaCount
        ot.textCount = textCount
        ot.renderType = type

        log.info "Save ${ot.html.bytes.length} bytes."
        log.info ot.save(flush: true)
    }

}
