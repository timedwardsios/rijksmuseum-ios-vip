
import Foundation
import Service

class AppDependencies:ServiceDependencies{
    lazy var apiSession: APISessionInterface = {
        return URLSession.shared
    }()
    lazy var apiConfig: APIConfigInterface = {
        return LiveAPIConfig()
    }()
    lazy var apiService: APIServiceInterface = {
        return APIService(dependencies: self)
    }()
    lazy var artService: ArtServiceInterface = {
        return ArtServiceAPI(dependencies: self)
    }()
    lazy var artDetailsService: ArtDetailsServiceInterface = {
        return ArtDetailsServiceAPI(dependencies: self)
    }()
}
