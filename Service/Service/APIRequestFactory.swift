
import Foundation
import Utils

enum APIEndpoint {
    case art
}

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

    private struct NetworkRequestAPI: NetworkRequest {
        var url: URL
        var method: NetworkMethod
    }


    func createRequest(withEndpoint endpoint: APIEndpoint) throws -> NetworkRequest {

        var urlComponents = URLComponents()
        urlComponents.scheme = apiConfig.scheme
        urlComponents.host = apiConfig.hostname
        urlComponents.path = apiConfig.path
        urlComponents.queryItems = apiConfig.queryItems

        switch endpoint {
        case .art:
            urlComponents.path.append("/collection")
            urlComponents.queryItems?.append(contentsOf: [URLQueryItem(name: "ps",
                                           value: "100"),
                              URLQueryItem(name: "imgonly",
                                           value: "true"),
                              URLQueryItem(name: "s",
                                           value: "relevance")])
        }

        return NetworkRequestAPI(url: urlComponents.url!, method: .GET)
    }
}


//            let queryItems = [URLQueryItem(name: QueryItemName.pageCount.rawValue,
//                                           value: "100"),
//                              URLQueryItem(name: QueryItemName.resultsWithImagesOnly.rawValue,
//                                           value: "true"),
//                              URLQueryItem(name: QueryItemName.sortBy.rawValue,
//                                           value: "relevance")]
