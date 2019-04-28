
import Foundation

public enum NetworkMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

public protocol NetworkRequest {
    var url: URL {get}
    var method: NetworkMethod {get}
}

public protocol NetworkService {
    func processNetworkRequest(_ request: NetworkRequest,
                        completion: @escaping (Result<Data, Error>) -> Void)
}

private struct NetworkRawResponseDefault: NetworkRawResponse {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Swift.Error?
}

internal class NetworkServiceDefault {

    private let networkSession: NetworkSession
    private let networkRawResponseValidator: NetworkRawResponseValidator

    init(networkSession: NetworkSession,
         networkRawResponseValidator: NetworkRawResponseValidator){
        self.networkSession = networkSession
        self.networkRawResponseValidator = networkRawResponseValidator
    }
}

extension NetworkServiceDefault: NetworkService {

    func processNetworkRequest(_ networkRequest: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) {

        let urlRequest = urlRequestForNetworkRequest(networkRequest)

        let dataTask = networkSession.dataTask(with: urlRequest) { [weak self] in
            guard let self = self else {
                return
            }

            let networkRawResponse = NetworkRawResponseDefault(data: $0, urlResponse: $1, error: $2)

            let validationResult = Result {
                try self.networkRawResponseValidator.validateResponse(networkRawResponse)
            }
            completion(validationResult)
        }
        dataTask.resume()
    }
}

private extension NetworkServiceDefault {

    func urlRequestForNetworkRequest(_ networkRequest: NetworkRequest) -> URLRequest {
        var urlRequest = URLRequest(url: networkRequest.url)
        urlRequest.httpMethod = networkRequest.method.rawValue
        return urlRequest
    }
}
