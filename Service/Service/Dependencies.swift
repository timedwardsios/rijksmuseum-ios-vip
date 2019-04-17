
import Foundation

public protocol Dependencies {
    func resolve() -> ArtService
}

extension Dependencies {
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
