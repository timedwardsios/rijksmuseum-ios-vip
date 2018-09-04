
import Foundation
import Service

class DependenciesDefault:ServiceDependencies{
    lazy var apiSession: APISession = {
        return URLSession.shared
    }()
    lazy var apiConfig: APIConfig = {
        return APIConfigLive()
    }()
    lazy var apiService: APIService = {
        return APIServiceDefault(apiSession: self.apiSession,
                          apiConfig: self.apiConfig)
    }()
    lazy var artService: ArtService = {
        return ArtServiceLive(apiService: self.apiService)
    }()
    lazy var artDetailsService: ArtDetailsService = {
        return ArtDetailsServiceLive(apiService: self.apiService)
    }()
}
