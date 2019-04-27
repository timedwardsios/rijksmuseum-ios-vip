
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
    func processRequest(_ request: NetworkRequest,
                        completion: @escaping (Result<Data, Error>) -> Void)
}

private struct NetworkResponseDefault: NetworkResponse {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Swift.Error?
}

private enum LocalError: String, LocalizedError{
    case badValidation = "Failed to validate network response"
}

internal class NetworkServiceDefault {

    private let networkSession: NetworkSession
    private let networkResponseValidator: NetworkResponseValidator

    init(networkSession: NetworkSession,
         networkResponseValidator: NetworkResponseValidator){
        self.networkSession = networkSession
        self.networkResponseValidator = networkResponseValidator
    }
}

extension NetworkServiceDefault: NetworkService {
    
    func processRequest(_ request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        let dataTask = networkSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let self = self else {
                return
            }
            let networkResponse = NetworkResponseDefault(data: data, urlResponse: response, error: error)
            do {
                let data = try self.networkResponseValidator.validateResponseAndUnwrapData(networkResponse)
                completion(.success(data))
            } catch {
                completion(.failure(LocalError.badValidation))
            }
        }

        dataTask.resume()
    }
}
