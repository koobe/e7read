class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        // "/"(view:"/index")
        "/" (controller: "home")

        "500"(view:'/error')

        "/me" (controller: 'user', action: 'profile')

        "/e/$hash" {
            controller = 'content'
            action = 'modify'
        }
	}
}
