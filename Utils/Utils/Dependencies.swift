
import Foundation

public protocol Dependencies {}

public extension Dependencies {
    func resolve() -> NetworkService {
        return NetworkServiceDefault(urlSession: resolve(),
                                     networkResponseValidator: resolve())
    }
}

private extension Dependencies {
    func resolve() -> URLSession {
        return Foundation.URLSession.shared
    }

    func resolve() -> NetworkResponseValidatorDefault {
        return NetworkResponseValidatorDefault()
    }
}
