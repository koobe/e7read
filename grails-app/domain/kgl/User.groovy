package kgl

class User {

	transient springSecurityService
	
	static searchable = {
		only = [
			'id', 
//			'location', 
			'username', 
			'fullName', 
			'email'
		]
//		location geoPoint: true, component: true
	}

	Long id
	
	String username
	String password

    String fullName
    String email

    String authType = "SYSTEM"        // SYSTEM, FACEBOOK
    String facebookId

    UserContact contact = new UserContact()

    //TODO
    // loginType

	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

    String lastIPAddress

    GeoPoint location

    static hasMany = [oAuthIDs: OAuthID]

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
		email nullable: true

        authType nullable: true
        facebookId nullable: true

        //contact nullable: true

        location nullable: true
        lastIPAddress nullable: true
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

        if (contact == null) {
            contact = new UserContact()
        }
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
