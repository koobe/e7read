package kgl

class LoginLog {
	
	Long userId
	
	String loginType
	
	String loginMethod
	
	Date timestamp
	
	String sessionId
	
	String userAgent

    static constraints = {
		loginMethod nullable: true
		userAgent nullable: true
		sessionId nullable: true
    }
}
