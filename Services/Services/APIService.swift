
import Utilities

public protocol APIServiceInterface {
    func performGet(request: APIRequestInterface,
                    completion: @escaping (Result<Data>) -> Void)
}

public class APIService{
    public typealias Dependencies = HasAPISession & HasAPIConfig
    let dependencies:Dependencies
    public init(dependencies:Dependencies){
        self.dependencies = dependencies
    }
}

extension APIService: APIServiceInterface {
    public func performGet(request: APIRequestInterface,
                           completion: @escaping (Result<Data>) -> Void){
        let url = urlFrom(config: dependencies.apiConfig,
                          request: request)
        dependencies.apiSession.dataTask(with: url) { (data, response, error) in
            let dataResult = self.dataResultFromSessionResponse(data,
                                                                response,
                                                                error)
            completion(dataResult)
        }.resume()
    }
}

private extension APIService {
    enum ServiceError:String,ResultError{
        case url
        case responseFormat
        case statusCode
        case data
    }

    func urlFrom(config:APIConfigInterface,
                 request:APIRequestInterface)->URL{
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
