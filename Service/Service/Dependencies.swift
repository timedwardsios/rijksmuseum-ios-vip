
import Foundation

public protocol ServiceDependencies {
    func resolve() -> ArtService
    func resolve() -> ArtDetailsService
}

extension ServiceDependencies {
    public func resolve() -> ArtDetailsService {
        return ArtDetailsServiceDefault(apiService: resolve())
    }

    public func resolve() -> ArtService {
        return ArtServiceDefault(apiService: resolve())
    }

    func resolve() -> APIService {
        return APIServiceDefault(apiSession: resolve(), apiConfig: resolve())
    }

    func resolve() -> APISession {
        return URLSession.shared
    }

    func resolve() -> APIConfig {
        return APIConfigDefault()
    }
}
