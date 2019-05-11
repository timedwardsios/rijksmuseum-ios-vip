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
        let apiBaseConfig = (resolve() as Config).apiBase
        return NetworkRequestFactoryDefault(apiBaseConfig: apiBaseConfig)
    }

    func resolve() -> ArtsFactory {
        return ArtsFactoryDefault(jsonDecoderService: resolve())
    }

    func resolve() -> JSONDecoder {
        return JSONDecoder()
    }

    func resolve() -> Config {
        let configService: ConfigFactory = resolve()
        return configService.getConfig()
    }

    func resolve() -> ConfigFactory {
        return ConfigFactoryDefault(jsonDecoderService: resolve(),
                                    fileManager: resolve())
    }

    func resolve() -> FileManager {
        return FileManager.default
    }
}
