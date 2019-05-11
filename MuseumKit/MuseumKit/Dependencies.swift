import Foundation
import TimKit

public protocol DependencyContainer {
    func resolve() -> ArtService
}

public class Dependencies {

    let timKitDependencyContainer: TimKit.DependencyContainer

    public init(timKitDependencyContainer: TimKit.DependencyContainer) {
        self.timKitDependencyContainer = timKitDependencyContainer
    }
}

extension Dependencies: DependencyContainer {

    public func resolve() -> ArtService {
        return ArtServiceDefault(apiRequestConfig: config.apiRequestConfig,
                                 networkRequestFactory: resolve(),
                                 networkService: timKitDependencyContainer.resolve(),
                                 artFactory: resolve())
    }
}

private extension Dependencies {
    func resolve() -> NetworkRequestFactory {
        return NetworkRequestFactoryDefault(baseAPIConfig: config.apiBaseConfig)
    }

    func resolve() -> ArtsFactory {
        return ArtsFactoryDefault(jsonDecoderService: resolve())
    }

    func resolve() -> JSONDecoder {
        return JSONDecoder()
    }

    func resolve() -> Bundle {
        return Bundle(for: type(of: self))
    }

    func resolve() -> Config {
        let configService: ConfigService = timKitDependencyContainer.resolve()
        return configService.getConfig(forBundle: resolve())
    }
}
