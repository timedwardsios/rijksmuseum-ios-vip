
import Foundation

public protocol NetworkService {
    func processRequest(_ request: NetworkRequest,
                        completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkServiceDefault{

    let urlSession: URLSession
    let networkResponseValidator: NetworkResponseValidator

    init(urlSession: URLSession,
         networkResponseValidator: NetworkResponseValidator){
        self.urlSession = urlSession
        self.networkResponseValidator = networkResponseValidator
    }
}

extension NetworkServiceDefault: NetworkService {
    enum LocalError: String, LocalizedError{
        case badValidation = "Failed to validate network response"
    }

    private struct NetworkResponseDefault: NetworkResponse {
        var data: Data?
        var urlResponse: URLResponse?
        var error: Swift.Error?
    }


    func processRequest(_ request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        let dataTask = urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
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
