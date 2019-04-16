
import Foundation
import Utils

public protocol ServiceAssembler {
    func resolve() -> ArtService
}

extension ServiceAssembler {
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
