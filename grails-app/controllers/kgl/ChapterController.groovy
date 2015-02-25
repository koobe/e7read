package kgl

class ChapterController {

    def index() { }
	
	def save(Chapter chapter) {

		if (!chapter.dataIndex) {
			def lastChapter = Chapter.findByBook(chapter.book, [sort: 'dataIndex', order: 'desc'])
			if (!lastChapter) {
				chapter.dataIndex = 1
			} else {
				chapter.dataIndex = lastChapter.dataIndex + 1
			}
		}
		
		chapter.save flush: true
		
		redirect uri: '/bookAdmin/chapterList/' + chapter?.book?.id
	}
	
	def update(Chapter chapter) {
		
		log.info params
		log.info chapter
		
		if (chapter) {
			log.info 'update chapter'	
		} else {
			log.info 'create chapter'
		}
	}
}
