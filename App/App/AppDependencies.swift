
import UIKit
import Services
import Utilities

struct AppDependencies{}

extension AppDependencies:HasAPISession {
    var apiSession: APISessionInterface {
        return URLSession.shared
    }
}

extension AppDependencies:HasAPIConfig {
    var apiConfig: APIConfigInterface {
        return LiveAPIConfig()
    }
}

extension AppDependencies:HasAPIService {
    var apiService: APIServiceInterface {
        return APIService(dependencies: self)
    }
}

extension AppDependencies:HasArtService {
    var artService: ArtServiceInterface {
        return ArtServiceAPI(dependencies: self)
    }
}

extension AppDependencies:HasArtDetailsService {
    var artDetailsService: ArtDetailsServiceInterface {
        return ArtDetailsServiceAPI(dependencies: self)
    }
}
