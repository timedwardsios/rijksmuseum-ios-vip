
import Foundation
import Services

struct AppDependencies:Dependencies{
    var apiSession: APISessionInterface {
        return URLSession.shared
    }
    var apiConfig: APIConfigInterface {
        return LiveAPIConfig()
    }
    var apiService: APIServiceInterface {
        return APIService(dependencies: self)
    }
    var artService: ArtServiceInterface {
        return ArtServiceAPI(dependencies: self)
    }
    var artDetailsService: ArtDetailsServiceInterface {
        return ArtDetailsServiceAPI(dependencies: self)
    }
}
