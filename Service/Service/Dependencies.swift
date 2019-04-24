
import Foundation
import Utils

public protocol Dependencies: Utils.Dependencies {
    func resolve() -> ArtService
}

public extension Dependencies {
    func resolve() -> ArtService {
        return ArtServiceDefault(apiRequestFactory: resolve(),
                                 networkService: resolve())
    }
}

private extension Dependencies {
    func resolve() -> APIRequestFactory {
        return APIRequestFactoryDefault(apiConfig: resolve())
    }

    func resolve() -> APIConfig {
        return APIConfigLive()
    }
}
