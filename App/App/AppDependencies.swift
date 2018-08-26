
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
        return APIService(apiSession: self.apiSession,
                          apiConfig: self.apiConfig)
    }()
    lazy var artService: ArtServiceProtocol = {
        return ArtServiceAPI(apiService: self.apiService)
    }()
    lazy var artDetailsService: ArtDetailsServiceProtocol = {
        return ArtDetailsServiceLive(apiService: self.apiService)
    }()
}
