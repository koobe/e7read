package kgl

import grails.transaction.Transactional
import grails.util.Environment
import org.codehaus.groovy.grails.web.pages.GroovyPagesTemplateEngine
import org.jsoup.Jsoup

import java.util.regex.Pattern

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
            template = OriginalTemplate.defaultTemplate
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

        if (content.isShowContact) {
            doc.select("body").append(renderContact(content));
        }

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

        // TODO clear cache not a good design
		// TODO cannot clear cache every time
        groovyPagesTemplateEngine.clearPageCache()
        //new GroovyPagesTemplateEngine()
        groovyPagesTemplateEngine
                .createTemplate(template?.html, "template-" + template?.name)?.make([content: content])?.writeTo(writer)

        // TODO provide render contact card expression support in GSP ?

        def doc = Jsoup.parse(writer.toString())

        if (content.isShowContact) {
            doc.select("div.template-container").append(renderContact(content));
        }

        return doc.html()
    }

    private String renderContact(Content content) {

        return """
			<div class="vcard-container padding-lr">
		    	<div class="vcard-cell-body">
		    		<div class="content-contact">
					    <ul class="basic">
					        <li class="avatar"><img src="//graph.facebook.com/${content.user.facebookId}/picture" alt="facebook-avatar" /></li>
					        <li class="fullName"><strong>${content.user.fullName}</strong></li>
					    </ul>
					    <ul class="advanced">
				        	<li class="email"><i class="fa fa-envelope-o"></i> ${content.user.email? content.user.email: ""}</li>
				        	<li class="phone"><i class="fa fa-phone"></i> ${content.user.contact?.phone? content.user.contact?.phone: ""}</li>
				        	<li class="phone"><i class="fa fa-skype"></i> ${content.user.contact?.skypeId? content.user.contact?.skypeId: ""}</li>
				        	<li class="lineId"><strong>Line:</strong> ${content.user.contact?.lineId? content.user.contact?.lineId: ""}</li>
					    </ul>
					</div>
		    	</div>
		    </div>
		"""
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

        def groups = ['default', 'experimental']

        groups.each { grouping ->

            def templatesDir = new File(templates, grouping)

            if (templatesDir.exists() && templatesDir.isDirectory()) {

                log.info "Import all HTML templates"
                loadTemplatesFromDirectory(templatesDir, grouping, ~/.*\.html/, '.html', OriginalTemplateRenderType.HTML)

                log.info "Import all GSP templates"
                loadTemplatesFromDirectory(templatesDir, grouping, ~/.*\.gsp/, '.gsp', OriginalTemplateRenderType.GSP)
            }
        }
    }

    private void loadTemplatesFromDirectory(File dir, String grouping, Pattern pattern, String suffix, OriginalTemplateRenderType type) {
        dir.eachFileMatch(pattern, {
            file ->
                log.info "Processing ${dir.absolutePath}"

                def baseName = file.name.replace(suffix, '')

                retrieveAttributes(saveTemplate(baseName, file.getText('UTF-8'), grouping, 0, 0, type))
        })
    }

    private void retrieveAttributes(OriginalTemplate template) {
        def doc = Jsoup.parse(template?.html)

        try {
            def mediaCount = doc.select("meta[name=kgl:media_count]").attr("content")
            def textCount = doc.select("meta[name=kgl:text_count]").attr("content")

            if (mediaCount?.isInteger()) {
                template.mediaCount = mediaCount.toInteger()
            }

            if (textCount?.isInteger()) {
                template.textCount = textCount.toInteger()
            }

            template.save flush: true
        }
        catch (e) {
            e.printStackTrace()
        }
    }

    private OriginalTemplate saveTemplate(String baseName, String html, String grouping,
                              int mediaCount, int textCount, OriginalTemplateRenderType type) {

        log.info "Write template to database: ${baseName})"

        def ot = OriginalTemplate.findOrCreateByNameAndGrouping(baseName, grouping)

        ot.name = baseName
        ot.html = html
        ot.grouping = grouping
        ot.mediaCount = mediaCount
        ot.textCount = textCount
        ot.renderType = type

        log.info "Save ${ot.html.bytes.length} bytes."
        log.info ot.save(flush: true)

        return ot
    }
}
