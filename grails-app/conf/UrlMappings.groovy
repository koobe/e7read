class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        // "/"(view:"/index")
        "/" (controller: "home")

        "/c/$c/$p?" {
            controller = 'home'
            action = 'index'
        }

        "500"(view:'/error')

        "/me" (controller: 'user', action: 'profile')

        "/e/$hash" {
            controller = 'content'
            action = 'modifyByHash'
        }

        "/share/$id" {
            controller = 'content'
            action = 'share'
        }
	}
}
