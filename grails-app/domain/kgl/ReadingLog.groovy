package kgl

import java.util.Date;

class ReadingLog {
	
	Long userId
	
	String sessionId
	
	String channelId
	
	String contentId
	
	Date timestamp
	
	String userAgent

    static constraints = {
		userId nullable: true
		sessionId nullable: true
		userAgent nullable: true
    }
}
