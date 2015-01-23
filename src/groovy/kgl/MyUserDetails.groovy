package kgl

import grails.plugin.springsecurity.userdetails.GrailsUser
import org.springframework.security.core.GrantedAuthority

/**
 * Created by lyhcode on 2014/7/1.
 */
class MyUserDetails extends GrailsUser {

    final String fullName
    final String email

    final User entity

    MyUserDetails(String username, String password, boolean enabled,
                  boolean accountNonExpired, boolean credentialsNonExpired,
                  boolean accountNonLocked,
                  Collection<GrantedAuthority> authorities,
                  long id, String email, String fullName) {

        super(username, password, enabled, accountNonExpired,
                credentialsNonExpired, accountNonLocked, authorities, id)

        this.email = email
        this.fullName = fullName

        //this.entity = entity
    }
}
