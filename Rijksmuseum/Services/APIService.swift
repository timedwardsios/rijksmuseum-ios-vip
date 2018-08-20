
import Foundation

protocol APIServiceInterface {
    func performGet(request: APIRequest, completion: @escaping (Result<Data,Error>) -> Void)
}

class APIService:APIServiceInterface{
    enum ServiceError:String,Error{
        case urlError
        case responseFormatError
        case statusCodeError
        case dataError
    }

    let apiSession: APISession
    let apiConfig: APIConfig
    init(apiSession: APISession,
         apiConfig: APIConfig) {
        self.apiSession = apiSession
        self.apiConfig = apiConfig
    }

    func performGet(request: APIRequest, completion: @escaping (Result<Data,Error>) -> Void){
        let url = urlFrom(config: apiConfig, request: request)
        let dataTask = apiSession.dataTask(with: url) { (data,response,error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ServiceError.responseFormatError))
                return
            }
            if !(200..<300 ~= httpResponse.statusCode) {
                completion(.failure(ServiceError.statusCodeError))
                return
            }
            guard let data = data else {
                completion(.failure(ServiceError.dataError))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }

    func urlFrom(config:APIConfig,
                       request:APIRequest)->URL{
        var urlComponents = URLComponents()
        urlComponents.scheme = config.scheme
        urlComponents.host = config.hostname
        urlComponents.path = config.path + request.endpoint
        urlComponents.queryItems = config.queryItems + request.queryItems
        return urlComponents.url! // outdated framework requires this
    }
}
