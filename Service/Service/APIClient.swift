
import Foundation
import Utils

protocol APIClient {
    func performRequest(request: APIRequest,
                        completion: @escaping (Result<Data, Error>) -> Void)
}

class APIClientDefault{
    let networkRequestFactory: NetworkRequestFactory
    let networkService: NetworkService
    let apiConfig: APIConfig
    init(networkRequestFactory: NetworkRequestFactory,
        networkService:NetworkService,
        apiConfig:APIConfig){
        self.networkRequestFactory = networkRequestFactory
        self.networkService = networkService
        self.apiConfig = apiConfig
    }
}

extension APIClientDefault: APIClient {
    func performRequest(request: APIRequest, completion: @escaping (Result<Data, Swift.Error>) -> Void){
        // TODO: extract this
        let url = urlFrom(config: apiConfig, request: request)


        let request = networkRequestFactory.createRequest(url: url, method: .GET)
        // TODO: sort out these functions
        networkService.processRequest(request) { (response) in
            do {
                completion(.success(try response.result.get()))
            } catch(let error) {
                completion(.failure(error))
            }
        }
    }
}

private extension APIClientDefault {
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
