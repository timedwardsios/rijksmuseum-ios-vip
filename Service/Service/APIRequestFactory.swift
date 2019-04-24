
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
    func createRequest(withEndpoint endpoint: APIEndpoint) throws -> NetworkRequest {

        var urlComponents = URLComponents()
        urlComponents.scheme = apiConfig.scheme
        urlComponents.host = apiConfig.hostname
        urlComponents.path = apiConfig.path
        urlComponents.queryItems = apiConfig.queryItems

        return NetworkRequestAPI(url: urlComponents.url!, method: .GET)
    }
}

private extension APIRequestFactoryDefault {
    enum LocalError: String, LocalizedError{
        case unknown
    }

    struct NetworkRequestAPI: NetworkRequest {
        var url: URL
        var method: NetworkMethod
    }
}


//            let queryItems = [URLQueryItem(name: QueryItemName.pageCount.rawValue,
//                                           value: "100"),
//                              URLQueryItem(name: QueryItemName.resultsWithImagesOnly.rawValue,
//                                           value: "true"),
//                              URLQueryItem(name: QueryItemName.sortBy.rawValue,
//                                           value: "relevance")]
