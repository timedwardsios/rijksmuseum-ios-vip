import Foundation
import TimKit

protocol APIConfig {

    var scheme: String { get }

    var host: String { get }

    var path: String { get }

    var queryItems: [String: String] {get}
}

enum HTTPMethod: String {
    case CONNECT
    case DELETE
    case GET
    case HEAD
    case OPTIONS
    case PATCH
    case POST
    case PUT
    case TRACE
}

protocol APIRequest {

    var path: String {get}

    var queryItems: [String: String] {get}

    var method: HTTPMethod {get}
}

enum URLRequestFactoryError: LocalizedError {

    case unableToConstructURL

    case invalidScheme

    case invalidHost

    case invalidPath
}

protocol URLRequestFactory {
    func constructURLRequestFromAPIRequest(_ apiRequest: APIRequest) throws -> URLRequest
}

class URLRequestFactoryDefault {
    let apiConfig: APIConfig
    init(apiConfig: APIConfig) {
        self.apiConfig = apiConfig
    }
}

extension URLRequestFactoryDefault: URLRequestFactory {

    func constructURLRequestFromAPIRequest(_ apiRequest: APIRequest) throws -> URLRequest {

        try validateAPIBaseConfig(apiConfig)

        try validateAPIRequest(apiRequest)

        let urlRequest = try urlRequestFromAPIRequest(apiRequest)

        return urlRequest
    }
}

// MARK: - Validation
private extension URLRequestFactoryDefault {

    func validateAPIBaseConfig(_ config: APIConfig) throws {

        try validateURLScheme(apiConfig.scheme)

        try validateURLHost(apiConfig.host)
    }

    func validateAPIRequest(_ apiRequest: APIRequest) throws {
        try validateURLPath(apiRequest.path)
    }

    func validateURLScheme(_ scheme: String) throws {

        if scheme != "http" && scheme != "https" {

            throw URLRequestFactoryError.invalidScheme
        }
    }

    func validateURLHost(_ host: String) throws {

        if apiConfig.host.isEmpty {

            throw URLRequestFactoryError.invalidHost
        }
    }

    func validateURLPath(_ path: String) throws {

        if path.isEmpty {

            throw URLRequestFactoryError.invalidPath
        }
    }
}

// MARK: - Creation
private extension URLRequestFactoryDefault {

    func urlRequestFromAPIRequest(_ apiRequest: APIRequest) throws -> URLRequest {

        var urlComponents = urlComponentsFromAPIBaseConfig(apiConfig)

        urlComponents = extendURLComponents(urlComponents, usingAPIRequest: apiRequest)

        let url = try urlFromURLComponents(urlComponents)

        let urlRequest = try urlRequestFromURL(url, apiRequest: apiRequest)

        return urlRequest
    }

    func urlComponentsFromAPIBaseConfig(_ apiBaseConfig: APIConfig) -> URLComponents {

        var newURLComponents = URLComponents()

        newURLComponents.scheme = apiBaseConfig.scheme
        newURLComponents.host = apiBaseConfig.host
        newURLComponents.path = apiBaseConfig.path

        newURLComponents.queryItems = apiBaseConfig.queryItems.map({
            return URLQueryItem(name: $0.key, value: $0.value)
        })

        return newURLComponents
    }

    func extendURLComponents(_ urlComponents: URLComponents, usingAPIRequest apiRequest: APIRequest) -> URLComponents {

        var newURLComponents = urlComponents

        newURLComponents.path.append(apiRequest.path)

        let newQueryItems = apiRequest.queryItems.map({ URLQueryItem(name: $0.key, value: $0.value) })

        newURLComponents.queryItems?.append(contentsOf: newQueryItems)
        return newURLComponents
    }

    func urlFromURLComponents(_ urlComponents: URLComponents) throws -> URL {

        guard let url = urlComponents.url else {
            throw URLRequestFactoryError.unableToConstructURL
        }

        return url
    }

    func urlRequestFromURL(_ url: URL, apiRequest: APIRequest) throws -> URLRequest {

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = apiRequest.method.rawValue

        return urlRequest
    }
}
