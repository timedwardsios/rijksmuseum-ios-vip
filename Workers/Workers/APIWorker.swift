
import Utilities

public protocol APIRequest {
    var path:String {get}
    var queryItems:[URLQueryItem] {get}
}

public protocol APIConfig:APIRequest {
    var scheme:String {get}
    var hostname:String {get}
}

public protocol APISession {
    typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletion) -> URLSessionDataTask
}
extension URLSession:APISession{}

public protocol APIWorkerInput {
    func performGet(request: APIRequest, completion: @escaping (Result<Data>) -> Void)
}

public class APIWorker{
    let apiSession: APISession
    let apiConfig: APIConfig
    public init(apiSession: APISession,
         apiConfig: APIConfig) {
        self.apiSession = apiSession
        self.apiConfig = apiConfig
    }
}

extension APIWorker: APIWorkerInput {
    public func performGet(request: APIRequest, completion: @escaping (Result<Data>) -> Void){
        let url = urlFrom(config: apiConfig, request: request)
        let dataTask = apiSession.dataTask(with: url) { (data,response,error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(Error.responseFormat))
                return
            }
            if !(200..<300 ~= httpResponse.statusCode) {
                completion(.failure(Error.statusCode))
                return
            }
            guard let data = data else {
                completion(.failure(Error.data))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}

private extension APIWorker {
    enum Error:String,ResultError{
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
}
