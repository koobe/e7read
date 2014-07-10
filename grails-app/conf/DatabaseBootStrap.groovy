import kgl.*

class DatabaseBootStrap {

    def init = { servletContext ->

        log.info "Create system roles and basic users."

    	// Create users
        def role1 = Role.findOrSaveByAuthority('ROLE_USER')
        def role2 = Role.findOrSaveByAuthority('ROLE_FACEBOOK')
        def role3 = Role.findOrSaveByAuthority('ROLE_ADMIN')

        //create administrator
        def user1 = User.findByUsername('admin')

        if (!user1) {
            user1 = new User(
                    fullName: 'Administrator',
                    email: 'admin@codecanaan.com',
                    username: 'admin',
                    password: 'admin',
                    enabled: true
            )
            user1.save(failOnError: true, flush: true)

            UserRole.create(user1, role1)
            //UserRole.create(user1, role2)
            UserRole.create(user1, role3)
        }

        // Create Original Template

        if (OriginalTemplate.count() == 0) {
            def template1 = new OriginalTemplate()
            template1.name = "default"
            template1.html = "<p>text</p>"
            template1.group = "A"
            template1.mediaCount = 2
            template1.textCount = 2
            template1.save flush: true
        }

    }
    def destroy = {
    }
}
