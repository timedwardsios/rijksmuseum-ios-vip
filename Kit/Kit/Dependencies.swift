import Foundation
import Utils

public class Dependencies {
    private let utilDependencies = Utils.Dependencies()

    public init() {}
}

public extension Dependencies {

    func resolve() -> ArtWorker {
        return ArtWorkerDefault(apiRequestFactory: resolve(),
                                networkRequestFactory: resolve(),
                                networkService: utilDependencies.resolve(),
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
