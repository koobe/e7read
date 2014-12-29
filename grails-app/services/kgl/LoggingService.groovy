package kgl


import grails.transaction.Transactional

@Transactional
class LoggingService {

    def addReadingLog(sessionId, userAgent, userId, channelId, contentId) {

		def dateStart = new Date().clearTime()
		def dateEnd = dateStart.plus(1)
		
		def rowCnt = ReadingLog.countByChannelIdAndContentIdAndSessionIdAndTimestampBetween(
			channelId,
			contentId,
			sessionId, 
			dateStart, 
			dateEnd);
		
		if (rowCnt == 0) {
			def readingLog = new ReadingLog(
				userId: userId,
				sessionId: sessionId,
				channelId: channelId,
				contentId: contentId,
				timestamp: new Date(),
				userAgent: userAgent
			)
			
			readingLog.save flush: true
		}
    }
}
