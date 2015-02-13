package kgl

import java.awt.GraphicsConfiguration.DefaultBufferCapabilities;

import javax.mail.Session;

class VirtualHostFilters {

    def filters = {
        all(controller: '*', action: '*') {
            before = {
				
				if (!session.vhostMapping) {
					
					log.info "(VirtualHost) check server hostname ${request.serverName}"
	
					def vhost = VirtualHost.findByHostname(request.serverName)
					def webtitle
					
					def currentChannel
	
					if (vhost) {
						currentChannel = vhost.channel
						webtitle = vhost.webpageTitle
					}
					else {
						currentChannel = Channel.findByIsDefault(true)
					}
	
					def vhostMapping = [:]
					vhostMapping.hostName = request.serverName
					vhostMapping.channelName = currentChannel.name
					vhostMapping.webpageTitle = webtitle
					
					session.vhostMapping = vhostMapping
					
//	                request.setAttribute('channel', currentChannel)
//					session.channelName = currentChannel.name
	
					log.info "(VirtualHost) auto mapping to channel[${currentChannel.name}]"
				}

//				if (request.getParameter('SSO_FB_TOKEN')) {
//					log.info "process sso fb token..."
//
//					def token = request.getParameter('SSO_FB_TOKEN')
//				}
                
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}