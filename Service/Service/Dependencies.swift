
import Foundation
import Utils

public protocol Dependencies: Utils.Dependencies {}

private extension Dependencies {
    func resolve() -> APIRequestFactory {
        return APIRequestFactoryDefault()
    }

    func resolve() -> NetworkRequestFactory {
        return NetworkRequestFactoryDefault(apiConfig: resolve())
    }

    func resolve() -> APIConfig {
        return APIConfigLive()
    }

    func resolve() -> JSONDecoder {
        return JSONDecoder()
    }
}
