
import Foundation
import Utils

public protocol APIService {
    func performGet(request: APIRequest,
                    completion: @escaping (Result<Data>) -> Void)
}

public class APIServiceDefault{
    public typealias Dependencies = HasAPISession & HasAPIConfig
    let apiSession: APISession
    let apiConfig: APIConfig
    public init(apiSession:APISession,
                apiConfig:APIConfig){
        self.apiSession = apiSession
        self.apiConfig = apiConfig
    }
}

extension APIServiceDefault: APIService {
    public func performGet(request: APIRequest,
                           completion: @escaping (Result<Data>) -> Void){
        let url = urlFrom(config: apiConfig,
                          request: request)
        apiSession.dataTask(with: url) { (data, response, error) in
            let dataResult = self.dataResultFromSessionResponse(data,
                                                                response,
                                                                error)
            completion(dataResult)
        }.resume()
    }
}

private extension APIServiceDefault {
    enum ServiceError:String,ResultError{
        case url
        case responseFormat
        case statusCode
        case data
    }

    func urlFrom(config:APIConfig,
                 request:APIRequest)->URL{
        var urlComponents = URLComponents()
        urlComponents.scheme = config.scheme
        urlComponents.host = config.hostname
        urlComponents.path = config.path + request.path
        urlComponents.queryItems = config.queryItems + request.queryItems
        return urlComponents.url! // outdated framework requires this
    }

    func dataResultFromSessionResponse(_ data:Data?,
                                       _ urlResponse:URLResponse?,
                                       _ error:Error?) -> Result<Data>{
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            return .failure(ServiceError.responseFormat)
        }
        if !(200..<300 ~= httpResponse.statusCode) {
            return .failure(ServiceError.statusCode)
        }
        guard let data = data else {
            return .failure(ServiceError.data)
        }
        return .success(data)
    }
}
