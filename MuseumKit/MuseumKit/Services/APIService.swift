import Foundation
import TimKit

enum APIServiceError: LocalizedError {

    case urlRequestFactoryFailure(Error)

    case networkResponseInvalid(Error)
}

protocol APIService {
    func performAPIRequest(_ apiRequest: APIRequest, completion: @escaping (Result<Data, APIServiceError>) -> Void)
}

private struct Response: NetworkResponse {

    var data: Data?

    var urlResponse: URLResponse?

    var error: Error?
}

class APIServiceDefault {

    let urlRequestFactory: URLRequestFactory
    let networkSession: NetworkSession
    let networkResponseValidator: NetworkResponseValidator

    init(urlRequestFactory: URLRequestFactory,
         networkSession: NetworkSession,
         networkResponseValidator: NetworkResponseValidator) {
        self.urlRequestFactory = urlRequestFactory
        self.networkSession = networkSession
        self.networkResponseValidator = networkResponseValidator
    }

    private var currentDataTask: NetworkSessionDataTask?
}

extension APIServiceDefault: APIService {

    func performAPIRequest(_ apiRequest: APIRequest, completion: @escaping (Result<Data, APIServiceError>) -> Void) {

        currentDataTask?.cancel()
        currentDataTask = nil

        do {
            let urlRequest = try urlRequestFactory.constructURLRequestFromAPIRequest(apiRequest)

            currentDataTask = networkSession.dataTask(with: urlRequest) { [weak self] in
                let response = Response(data: $0, urlResponse: $1, error: $2)
                self?.didPerformAPIRequest(response: response, completion: completion)
            }

            currentDataTask?.resume()

        } catch let error {
            completion(.failure(.urlRequestFactoryFailure(error)))
        }
    }
}

private extension APIServiceDefault {

    func didPerformAPIRequest(response: NetworkResponse, completion: (Result<Data, APIServiceError>) -> Void) {
        do {
            let data = try networkResponseValidator.validateResponse(response)

            completion(.success(data))

        } catch let error as NetworkResponseValidatorError {

            guard case .cancelled = error else {
                completion(.failure(.networkResponseInvalid(error)))
                return
            }

        } catch let error {
            completion(.failure(.networkResponseInvalid(error)))
        }
    }
}
