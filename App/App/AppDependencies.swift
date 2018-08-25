
import Foundation
import Service

class AppDependencies:ServiceDependencies{
    lazy var apiSession: APISessionProtocol = {
        return URLSession.shared
    }()
    lazy var apiConfig: APIConfigProtocol = {
        return LiveAPIConfig()
    }()
    lazy var apiService: APIServiceProtocol = {
        return APIService(dependencies: self)
    }()
    lazy var artService: ArtServiceProtocol = {
        return ArtServiceAPI(dependencies: self)
    }()
    lazy var artDetailsService: ArtDetailsServiceProtocol = {
        return ArtDetailsServiceLive(dependencies: self)
    }()
}
