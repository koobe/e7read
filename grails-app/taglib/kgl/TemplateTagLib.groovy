package kgl

import grails.plugin.geocode.Point

class TemplateTagLib {

    def markdownService

    def geocodingService

    static namespace = "template"
    //static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    def socialToolbar = { attrs, body ->
        out << render(template: '/taglib/template/socialToolbar', model: [content: attrs.content])
    }
	
	def imageTitle = { attrs, body ->
		out << render(template: '/template/component/image_title', 
			model: [
				content: attrs.content,
				classOfImage: attrs.classOfImage,
				classOfTitle: attrs.classOfTitle,
				styleOfTitle: attrs.styleOfTitle,
				classOfDate: attrs.classOfDate,
				styleOfDate: attrs.styleOfDate,
				showDate: attrs.showDate
			])
	}
	
	def containerTexts = { attrs, body ->
        //def contentTexts = attrs.content?.textSegments?.collect { markdownService.sanitize(it.text) }
		//out << render(template: '/template/component/container_texts', model: [contentTexts: contentTexts])
        out << render(template: '/template/component/container_texts', model: [content: attrs.content])
	}
	
	def containerPicturesType1 = { attrs, body ->
		out << render(template: '/template/component/container_pictures_type1', model: [content: attrs.content])
	}
	
	def sectionTitle = { attrs, body ->
		out << render(template: '/template/component/section_title', model: [title: attrs.title])
	}
	
	def categoriesTable = { attrs, body ->
		out << render(template: '/template/component/categories_table', model: [content: attrs.content])
	}
	
	def contentHeaderView = { attrs, body ->
		out << render(template: '/template/headerview', model: [content: attrs.content])
	}
	
	def contentParagraphView = { attrs, body -> 
		
		def PAGEVIEWSIZE = 4
		def textSegments = attrs.content?.textSegments.toArray()
		
		log.info 'text segments size: ' + textSegments.size()
		
		def textPageId = 0;
		def currIdx = 0
		while (true) {
			if ((textSegments.size() - currIdx) <= 0) {
				break
			}
			textPageId++
			
			def endIdx
			if (currIdx+PAGEVIEWSIZE >= textSegments.size()) {
				endIdx = textSegments.size() - 1
			} else {
				endIdx = currIdx+PAGEVIEWSIZE - 1
			}
			
			def segments = textSegments[currIdx..endIdx]
			out << render(template: '/template/paragraphview', 
				model: [segments: segments, pageId: textPageId, title: attrs.content.cropTitle])
			
			currIdx = currIdx + PAGEVIEWSIZE
		}
	}
}
