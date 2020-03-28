import Foundation
import Combine

enum WebRepositoryError: LocalizedError  {
    case requestError(Error)
    case urlError(Error)
    case badResponse
    case badStatusCode

    var errorDescription: String? {
        switch self {
        case let .requestError(error),
             let .urlError(error): return "Internal error: \(error)"
        case .badResponse: return "Recieved a bad response format from URLSession"
        case .badStatusCode: return "Recieved a bad status code"
        }
    }
}

public protocol WebRepository {
    var config: WebRepositoryConfig { get }
    var webSession: WebSession { get }
    var jsonDecoder: JSONDecoder { get }
    func publisher<R: WebRequest>(forWebRequest webRequest: R) -> AnyPublisher<R.JSONType, Error>
}

public extension WebRepository {
    func publisher<R: WebRequest>(forWebRequest webRequest: R) -> AnyPublisher<R.JSONType, Error> {
        Just(webRequest)
            .tryMap { try $0.urlRequest(givenConfig: self.config) }
            .mapError { WebRepositoryError.requestError($0) }
            .flatMap {
                self.webSession.dataTaskPublisher(for: $0)
                    .mapError { WebRepositoryError.urlError($0) }}
            .processRespsonse()
            .decode(type: R.JSONType.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func processRespsonse() -> AnyPublisher<Data, Error> {
        tryMap {
            guard let response = $0.1 as? HTTPURLResponse else {
                throw WebRepositoryError .badResponse
            }
            guard 200..<300 ~= response.statusCode else {
                throw WebRepositoryError .badStatusCode
            }
            return $0.0
        }
        .eraseToAnyPublisher()
    }
}
