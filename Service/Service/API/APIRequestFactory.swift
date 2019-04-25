
import Foundation
import Utils

protocol APIRequestFactory {
    func createRequest(withEndpoint apiEndpoint:APIEndpoint) throws -> NetworkRequest
}

class APIRequestFactoryDefault{
    let apiConfig: APIConfig
    init(apiConfig:APIConfig){
        self.apiConfig = apiConfig
    }
}

extension APIRequestFactoryDefault: APIRequestFactory {
    private enum LocalError: String, LocalizedError{
        case unableToConstructURL
        case invalidConfigScheme
        case invalidConfigHostname
        case invalidEndpointPath
    }

    private struct APINetworkRequest: NetworkRequest {
        var url: URL
        var method: NetworkMethod
    }
    

    func createRequest(withEndpoint apiEndpoint: APIEndpoint) throws -> NetworkRequest {

        if apiConfig.scheme != "http" && apiConfig.scheme != "https" {
            throw LocalError.invalidConfigScheme
        }

        if apiConfig.host.isEmpty {
            throw LocalError.invalidConfigHostname
        }

        if apiEndpoint.path.isEmpty {
            throw LocalError.invalidEndpointPath
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = apiConfig.scheme
        urlComponents.host = apiConfig.host
        urlComponents.path = apiConfig.path
        urlComponents.queryItems = apiConfig.queryItems

        urlComponents.path.append(apiEndpoint.path)
        urlComponents.queryItems?.append(contentsOf: apiEndpoint.queryItems)

        guard let url = urlComponents.url else {
            throw LocalError.unableToConstructURL
        }

        return APINetworkRequest(url: url, method: .GET)
    }
}
