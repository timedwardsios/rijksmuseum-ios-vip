import Foundation

enum APIServiceError: String, LocalizedError{
    case responseFormat = "Invalid response format"
    case statusCode = "Invalid status code"
    case data = "No data"
}

protocol APIService {
    func performGet(request: APIRequest,
                    completion: @escaping (Result<Data, Error>) -> Void)
}

class APIServiceDefault{
    let apiSession: APISession
    let apiConfig: APIConfig
    init(apiSession:APISession,
                apiConfig:APIConfig){
        self.apiSession = apiSession
        self.apiConfig = apiConfig
    }
}

extension APIServiceDefault: APIService {
    func performGet(request: APIRequest, completion: @escaping (Result<Data, Error>) -> Void){
        let url = APIServiceDefault.urlFrom(config: apiConfig, request: request)
        apiSession.dataTask(with: url) { (data, response, error) in
            let dataResult = APIServiceDefault.dataResultFromSessionResponse(data, response, error)
            completion(dataResult)
            }.resume()
    }
}

private extension APIServiceDefault {
    static func urlFrom(config:APIConfig, request:APIRequest)->URL{
        var urlComponents = URLComponents()
        urlComponents.scheme = config.scheme
        urlComponents.host = config.hostname
        urlComponents.path = config.path + request.path
        urlComponents.queryItems = config.queryItems + request.queryItems
        return urlComponents.url! // outdated framework requires this
    }

    static func dataResultFromSessionResponse(_ data:Data?,
                                              _ urlResponse:URLResponse?,
                                              _ error:Error?) -> Result<Data, Error>{
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            return .failure(APIServiceError.responseFormat)
        }
        if !(200..<300 ~= httpResponse.statusCode) {
            return .failure(APIServiceError.statusCode)
        }
        guard let data = data else {
            return .failure(APIServiceError.data)
        }
        return .success(data)
    }
}
