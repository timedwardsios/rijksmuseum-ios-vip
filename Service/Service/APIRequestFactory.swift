
import Foundation
import Utils

protocol APIRequestFactory {
    func createRequest(withEndpoint endpoint:APIEndpoint) throws -> NetworkRequest
}

class APIRequestFactoryDefault{
    let apiConfig: APIConfig
    init(apiConfig:APIConfig){
        self.apiConfig = apiConfig
    }
}

extension APIRequestFactoryDefault: APIRequestFactory {
    private enum LocalError: String, LocalizedError{
        case invalidScheme
    }

    private struct NetworkRequestAPI: NetworkRequest {
        var url: URL
        var method: NetworkMethod
    }
    

    func createRequest(withEndpoint endpoint: APIEndpoint) throws -> NetworkRequest {

        if apiConfig.scheme != "http" && apiConfig.scheme != "https" {
            throw LocalError.invalidScheme
        }
        // TODO: Finish error handling
        if apiConfig. != "http" && apiConfig.scheme != "https" {
            throw LocalError.invalidScheme
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = apiConfig.scheme
        urlComponents.host = apiConfig.hostname
        urlComponents.path = apiConfig.path
        urlComponents.queryItems = apiConfig.queryItems

        urlComponents.path.append(endpoint.path)
        urlComponents.queryItems?.append(contentsOf: endpoint.queryItems)

        return NetworkRequestAPI(url: urlComponents.url!, method: .GET)
    }
}


//            let queryItems = [URLQueryItem(name: QueryItemName.pageCount.rawValue,
//                                           value: "100"),
//                              URLQueryItem(name: QueryItemName.resultsWithImagesOnly.rawValue,
//                                           value: "true"),
//                              URLQueryItem(name: QueryItemName.sortBy.rawValue,
//                                           value: "relevance")]
