
import Foundation
import Utils

public protocol Dependencies: Utils.Dependencies {}

public extension Dependencies {

    func resolve() -> ArtWorker {
        return ArtWorkerDefault(apiRequestFactory: resolve(),
                                networkRequestFactory: resolve(),
                                networkService: resolve(),
                                artFactory: resolve())
    }
}

private extension Dependencies {

    func resolve() -> APIRequestFactory {
        return APIRequestFactoryDefault()
    }

    func resolve() -> NetworkRequestFactory {
        return NetworkRequestFactoryDefault(apiConfig: resolve())
    }

    func resolve() -> ArtFactory {
        return ArtFactoryDefault(jsonDecoderService: resolve())
    }

    func resolve() -> APIConfig {
        return APIConfigLive()
    }

    func resolve() -> JSONDecoder {
        return JSONDecoder()
    }
}
