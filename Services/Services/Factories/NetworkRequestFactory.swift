
import Foundation
import Utils

internal protocol APIConfig {
    var path: String {get}
    var queryItems: [URLQueryItem] {get}
    var scheme: String {get}
    var host: String {get}
}

internal protocol NetworkRequestFactory {
    func createRequest(fromAPIRequest apiRequest:APIRequest) throws -> NetworkRequest
}

private struct APINetworkRequest: NetworkRequest {
    var url: URL
    var method: NetworkMethod
}

internal class NetworkRequestFactoryDefault{
    let apiConfig: APIConfig
    init(apiConfig:APIConfig){
        self.apiConfig = apiConfig
    }
}

private enum LocalError: String, LocalizedError{
    case unableToConstructURL
    case invalidConfigScheme
    case invalidConfigHost
    case invalidEndpointPath
}

extension NetworkRequestFactoryDefault: NetworkRequestFactory {
    
    func createRequest(fromAPIRequest apiRequest: APIRequest) throws -> NetworkRequest {

        if apiConfig.scheme != "http" && apiConfig.scheme != "https" {
            throw LocalError.invalidConfigScheme
        }

        if apiConfig.host.isEmpty {
            throw LocalError.invalidConfigHost
        }

        if apiRequest.path.isEmpty {
            throw LocalError.invalidEndpointPath
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = apiConfig.scheme
        urlComponents.host = apiConfig.host
        urlComponents.path = apiConfig.path
        urlComponents.queryItems = apiConfig.queryItems

        urlComponents.path.append(apiRequest.path)
        urlComponents.queryItems?.append(contentsOf: apiRequest.queryItems)

        guard let url = urlComponents.url else {
            throw LocalError.unableToConstructURL
        }

        return APINetworkRequest(url: url, method: .GET)
    }
}
