
import Foundation
import Utils

protocol APIService {
    func performRequest(request: APIRequest,
                        completion: @escaping (Result<Data, Error>) -> Void)
}

class APIServiceDefault{
    let networkService: NetworkService
    let apiConfig: APIConfig
    init(networkService:NetworkService,
        apiConfig:APIConfig){
        self.networkService = networkService
        self.apiConfig = apiConfig
    }
}

extension APIServiceDefault: APIService {
    func performRequest(request: APIRequest, completion: @escaping (Result<Data, Swift.Error>) -> Void){
        let url = urlFrom(config: apiConfig, request: request)
        
    }
}

private extension APIServiceDefault {
    enum Error: String, LocalizedError{
        case networkError = "An error occured with the network"
    }

    func urlFrom(config:APIConfig, request:APIRequest)->URL{
        var urlComponents = URLComponents()
        urlComponents.scheme = config.scheme
        urlComponents.host = config.hostname
        urlComponents.path = config.path + request.path
        urlComponents.queryItems = config.queryItems + request.queryItems
        return urlComponents.url! // outdated framework requires this
    }
}
