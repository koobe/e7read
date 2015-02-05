package kgl

class VirtualHostFilters {

    def filters = {
        all(controller: '*', action: '*') {
            before = {

                log.info "(VirtualHost) check server hostname ${request.serverName}"

                def vhost = VirtualHost.findByHostname(request.serverName)

                def currentChannel

                if (vhost) {
                    currentChannel = vhost.channel
                }
                else {
                    currentChannel = Channel.findByIsDefault(true)
                }

                request.setAttribute('channel', currentChannel)
                session.channelName = currentChannel.name

                log.info "(VirtualHost) auto mapping to channel[${currentChannel.name}]"
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
