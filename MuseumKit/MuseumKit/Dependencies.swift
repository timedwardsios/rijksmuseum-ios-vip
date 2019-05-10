import Foundation
import TimKit

public let dependencies: Dependencies = DependenciesDefault()

public protocol Dependencies {
    func resolve() -> ArtService
}

private class DependenciesDefault: Dependencies {

    func resolve() -> ArtService {
        return ArtServiceDefault(apiRequestFactory: resolve(),
                                networkRequestFactory: resolve(),
                                networkService: TimKit.dependencies.resolve(),
                                artFactory: resolve())
    }

    func resolve() -> APIRequestFactory {
        return APIRequestFactoryDefault()
    }

    func resolve() -> NetworkRequestFactory {
        return NetworkRequestFactoryDefault(apiConfig: resolve())
    }

    func resolve() -> ArtsFactory {
        return ArtsFactoryDefault(jsonDecoderService: resolve())
    }

    func resolve() -> APIConfig {
        return APIConfigLive()
    }

    func resolve() -> JSONDecoder {
        return JSONDecoder()
    }
}
