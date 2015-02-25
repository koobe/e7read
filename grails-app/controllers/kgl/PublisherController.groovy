package kgl

class PublisherController {

    def index() { }
	
	def save(Publisher publisher) {
		
		publisher.save flush:true
		
		redirect uri: '/bookAdmin/publisherList'
	}
}
