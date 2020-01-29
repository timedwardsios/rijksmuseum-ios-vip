import Foundation

public let dependencies = Dependencies()

public struct Dependencies {
    public func resolve(apiConfig: APIConfig) -> APIService {
        APIServiceDefault(apiConfig: apiConfig, urlSession: resolve(), jsonDecoder: resolve())
    }
}

private extension Dependencies {
    func resolve() -> URLSession { Foundation.URLSession.shared }
    func resolve() -> JSONDecoder { Foundation.JSONDecoder() }
}
