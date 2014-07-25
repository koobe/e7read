package kgl

class User {

	transient springSecurityService

	String username
	String password

    String fullName
    String email

    String authType        // SYSTEM, FACEBOOK
    String facebookId

    String phone
    String facebookUrl
    String blogUrl
    String lineId
    String skypeId

    String description

    //TODO
    // loginType

	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

    static hasMany = [oAuthIDs: OAuthID]

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
		email nullable: true

        authType nullable: true
        facebookId nullable: true

        phone nullable: true
        facebookUrl nullable: true
        blogUrl nullable: true
        lineId nullable: true
        skypeId nullable: true

        description nullable: true, maxSize: 1024 * 1024
	}

	static mapping = {
		table '`user`'
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role }
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}
}
