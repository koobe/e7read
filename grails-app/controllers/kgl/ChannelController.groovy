package kgl

class ChannelController {

    def index() { }
	
	def addChannelPanel() {
		render template: "channel_panel", model:[channels: Channel.findAllByShowInPanel(true, [sort: 'order'])]
	}
}
