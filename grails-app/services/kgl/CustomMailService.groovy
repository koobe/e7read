package kgl

import grails.transaction.Transactional

@Transactional
class CustomMailService {

    def serverStartupNotification(toAddress) {
        sendMail {
            to toAddress
            subject "[E7READ] starting service"
            body "${new Date()} / ${InetAddress.getLocalHost().hostAddress}"
        }
    }
}
