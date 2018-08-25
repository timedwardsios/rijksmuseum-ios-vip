
import UIKit
import Services
import Utilities

struct AppDependencies{}

extension AppDependencies:HasApiService {
    var apiService: APIServiceInterface {
        let apiSession = URLSession.shared
        let apiConfig = LiveAPIConfig()
        return APIService(apiSession: apiSession,
                          apiConfig: apiConfig)
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
