import Foundation

public let dependencies: Dependencies = DependenciesDefault()

public protocol Dependencies {
    func resolve() -> NetworkService
}

class DependenciesDefault: Dependencies {

    func resolve() -> NetworkService {
        return NetworkServiceDefault(networkSession: resolve(),
                                     networkRawResponseValidator: resolve())
    }

    func resolve() -> NetworkSession {
        return URLSession.shared
    }

    func resolve() -> NetworkRawResponseValidatorDefault {
        return NetworkRawResponseValidatorDefault()
    }
}
