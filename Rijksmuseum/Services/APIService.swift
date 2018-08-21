
import Foundation

enum APIServiceError:Error{
    case url
    case responseFormat
    case statusCode
    case data
}

typealias APIServiceResult = Result<Data, APIServiceError>

protocol APIServiceInput {
    func performGet(request: APIRequest, completion: @escaping (APIServiceResult) -> Void)
}

class APIService{
    let apiSession: APISession
    let apiConfig: APIConfig
    init(apiSession: APISession,
         apiConfig: APIConfig) {
        self.apiSession = apiSession
        self.apiConfig = apiConfig
    }
}

extension APIService: APIServiceInput {
    func performGet(request: APIRequest, completion: @escaping (APIServiceResult) -> Void){
        let url = urlFrom(config: apiConfig, request: request)
        let dataTask = apiSession.dataTask(with: url) { (data,response,error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.responseFormat))
                return
            }
            if !(200..<300 ~= httpResponse.statusCode) {
                completion(.failure(.statusCode))
                return
            }
            guard let data = data else {
                completion(.failure(.data))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}

private extension APIService {
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
