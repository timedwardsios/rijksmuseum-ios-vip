
import Foundation

public protocol Dependencies {
    func resolve() -> ArtService
}

extension Dependencies {
    public func resolve() -> ArtService {
        return ArtServiceDefault(apiService: resolve())
    }

    func resolve() -> APIService {
        return APIServiceDefault(networkService: resolve(), apiConfig: resolve())
    }

    func resolve() -> NetworkService {
        return NetworkServiceDefault(networkSession: resolve())
    }

    func resolve() -> NetworkSession {
        return URLSession.shared
    }

    func resolve() -> APIConfig {
        return APIConfigDefault()
    }
}
