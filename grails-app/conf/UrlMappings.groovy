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
		"/maphome/$channel?" (controller: 'home', action: 'mapHome')
		
		"/content/create/$channel?" (controller: 'content', action: 'create')
		"/content/personal/$channel?" (controller: 'content', action: 'personal')
//		"/content/shorten/$channel?" (controller: 'content', action: 'shorten')

        "/explore/$channel?" (controller: 'map', action: 'explore')

        "/mapStyleFromSnazzy/$id/$name?" (controller: 'mapStyle', action: 'snazzy')

        "/mapStyle/$id?.json" (controller: 'mapStyle', action: 'json')

        "/mapStyle/$id?.png" (controller: 'mapStyle', action: 'image')

        "/locale/$bundle?.json" (controller: 'locale', action: 'json')

        "/locale/$bundle?.js" (controller: 'locale', action: 'javascript')
//        "/locale/$group" (controller: 'locale', action: 'json')
    }
}
