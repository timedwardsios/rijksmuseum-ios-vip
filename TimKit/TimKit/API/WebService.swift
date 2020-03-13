import Foundation
import Combine

enum WebServiceError  {
    case requestError(Error)
    case urlError(Error)
    case badResponse
    case badStatusCode
}

extension WebServiceError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .requestError(error),
             let .urlError(error): return "Internal error: \(error)"
        case .badResponse: return "Recieved a bad response format from URLSession"
        case .badStatusCode: return "Recieved a bad status code"
        }
    }
}

public protocol WebService {
    var config: WebServiceConfig { get }
    var urlSession: URLSession { get }
    var jsonDecoder: JSONDecoder { get }
    func performRequest<R: WebRequest>(_ apiRequest: R) -> AnyPublisher<R.JSONType, Error>
}

public extension WebService {
    func performRequest<R: WebRequest>(_ apiRequest: R) -> AnyPublisher<R.JSONType, Error> {
        Just(apiRequest)
            .tryMap { try $0.urlRequest(givenConfig: self.config) }
            .mapError { WebServiceError.requestError($0) }
            .flatMap {
                self.urlSession.dataTaskPublisher(for: $0)
                    .mapError { WebServiceError.urlError($0) }}
            .validateRespsonse()
            .decode(type: R.JSONType.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func validateRespsonse() -> AnyPublisher<Data, Error> {
        tryMap {
            guard let response = $0.1 as? HTTPURLResponse else {
                throw WebServiceError .badResponse
            }
            guard 200..<300 ~= response.statusCode else {
                throw WebServiceError .badStatusCode
            }
            return $0.0
        }
        .eraseToAnyPublisher()
    }
}
