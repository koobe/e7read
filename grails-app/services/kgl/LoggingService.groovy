package kgl


import grails.transaction.Transactional

import java.util.concurrent.Callable;
import java.util.concurrent.Executors

@Transactional
class LoggingService {
	
	def logginPool = Executors.newFixedThreadPool(50)
	
	def runnableAddReadingLog = { sessionId, userAgent, userId, channelId, contentId ->
		
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

    def addReadingLog(sessionId, userAgent, userId, channelId, contentId) {
		
		logginPool.submit(runnableAddReadingLog(sessionId, userAgent, userId, channelId, contentId) as Callable)
    }
}
