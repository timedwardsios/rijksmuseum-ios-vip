
import Utilities

public protocol HasQueryItems {
    var queryItems:[URLQueryItem] {get}
}

public protocol HasEndpoint {
    var endpoint:String {get}
}

public protocol HasBaseURL {
    var scheme:String {get}
    var hostname:String {get}
    var path:String {get}
}

public typealias NetworkConfig = HasBaseURL & HasQueryItems
public typealias NetworkRequest = HasEndpoint & HasQueryItems

public protocol NetworkSession {
    typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletion) -> URLSessionDataTask
}
extension URLSession:NetworkSession{}

public protocol NetworkWorkerInput {
    func performGet(request: NetworkRequest, completion: @escaping (Result<Data>) -> Void)
}

public class NetworkWorker{
    let networkSession: NetworkSession
    let networkConfig: NetworkConfig
    public init(networkSession: NetworkSession,
         networkConfig: NetworkConfig) {
        self.networkSession = networkSession
        self.networkConfig = networkConfig
    }
}

extension NetworkWorker: NetworkWorkerInput {
    public func performGet(request: NetworkRequest, completion: @escaping (Result<Data>) -> Void){
        let url = urlFrom(config: networkConfig, request: request)
        let dataTask = networkSession.dataTask(with: url) { (data,response,error) in
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

private extension NetworkWorker {
    enum Error:Swift.Error{
        case url
        case responseFormat
        case statusCode
        case data
    }

    func urlFrom(config:NetworkConfig,
                 request:NetworkRequest)->URL{
        var urlComponents = URLComponents()
        urlComponents.scheme = config.scheme
        urlComponents.host = config.hostname
        urlComponents.path = config.path + request.endpoint
        urlComponents.queryItems = config.queryItems + request.queryItems
        return urlComponents.url! // outdated framework requires this
    }
}
