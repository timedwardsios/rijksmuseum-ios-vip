import Foundation

public protocol Dependencies {}

public extension Dependencies {

    func resolve() -> NetworkService {
        return NetworkServiceDefault(networkSession: resolve(),
                                     networkRawResponseValidator: resolve())
    }
}

private extension Dependencies {

    func resolve() -> NetworkSession {
        return URLSession.shared
    }

    func resolve() -> NetworkRawResponseValidatorDefault {
        return NetworkRawResponseValidatorDefault()
    }
}
