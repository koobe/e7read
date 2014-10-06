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
		"404"(view:'/notfound')

        "/me" (controller: 'user', action: 'profile')

        "/e/$hash" {
            controller = 'content'
            action = 'modifyByHash'
        }

        "/share/$id" {
            controller = 'content'
            action = 'share'
        }
		
		"/$channel?" (controller: 'home', action: 'index')
		
		"/content/create/$channel?" (controller: 'content', action: 'create')
		"/content/personal/$channel?" (controller: 'content', action: 'personal')
//		"/content/shorten/$channel?" (controller: 'content', action: 'shorten')
	}
}
