
import Foundation
import Utils

internal protocol APIConfig {
    var path: String {get}
    var queryItems: [URLQueryItem] {get}
    var scheme: String {get}
    var host: String {get}
}

internal protocol NetworkRequestFactory {
    func networkRequest(fromAPIRequest apiRequest:APIRequest) throws -> NetworkRequest
}

internal class NetworkRequestFactoryDefault{
    let apiConfig: APIConfig
    init(apiConfig:APIConfig){
        self.apiConfig = apiConfig
    }
}

extension NetworkRequestFactoryDefault: NetworkRequestFactory {
    
    func networkRequest(fromAPIRequest apiRequest: APIRequest) throws -> NetworkRequest {

        try validateAPIConfig(apiConfig)

        try validateAPIRequest(apiRequest)

        let networkRequestURL = try urlFromAPIConfig(apiConfig, apiRequest: apiRequest)

        let networkRequest = networkRequestFromURL(networkRequestURL, networkMethod: .GET)

        return networkRequest
    }
}

private extension NetworkRequestFactoryDefault {

    enum LocalError: String, LocalizedError{
        case unableToConstructURL
        case invalidScheme
        case invalidHost
        case invalidPath
    }

    struct NetworkRequestForAPI: NetworkRequest {
        var url: URL
        var method: NetworkMethod
    }

    func validateAPIConfig(_ config: APIConfig) throws {
        try validateURLScheme(apiConfig.scheme)
        try validateURLHost(apiConfig.host)
    }

    func validateAPIRequest(_ apiRequest: APIRequest) throws {
        try validateURLPath(apiRequest.path)
    }

    func urlFromAPIConfig(_ config: APIConfig, apiRequest: APIRequest) throws -> URL {

        let urlComponents = urlComponentsFromAPIConfig(apiConfig)

        let urlComponentsExtended = extendURLComponents(urlComponents, usingAPIRequest: apiRequest)

        let finalURL = try urlFromURLComponents(urlComponentsExtended)

        return finalURL
    }

    func networkRequestFromURL(_ url: URL, networkMethod: NetworkMethod) -> NetworkRequest {
        return NetworkRequestForAPI(url: url, method: networkMethod)
    }
}

// MARK: - Validation
private extension NetworkRequestFactoryDefault {
    func validateURLScheme(_ scheme: String) throws {
        if scheme != "http" && scheme != "https" {
            throw LocalError.invalidScheme
        }
    }

    func validateURLHost(_ host: String) throws {
        if apiConfig.host.isEmpty {
            throw LocalError.invalidHost
        }
    }

    func validateURLPath(_ path: String) throws {
        if path.isEmpty {
            throw LocalError.invalidPath
        }
    }
}

// MARK: - Creation
private extension NetworkRequestFactoryDefault {

    func urlComponentsFromAPIConfig(_ apiConfig:APIConfig) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = apiConfig.scheme
        urlComponents.host = apiConfig.host
        urlComponents.path = apiConfig.path
        urlComponents.queryItems = apiConfig.queryItems
        return urlComponents
    }

    func extendURLComponents(_ urlComponents:URLComponents, usingAPIRequest apiRequest: APIRequest) -> URLComponents {
        var newURLComponents = urlComponents
        newURLComponents.path.append(apiRequest.path)
        newURLComponents.queryItems?.append(contentsOf: apiRequest.queryItems)
        return newURLComponents
    }

    func urlFromURLComponents(_ urlComponents: URLComponents) throws -> URL {
        guard let url = urlComponents.url else {
            throw LocalError.unableToConstructURL
        }
        return url
    }
}
