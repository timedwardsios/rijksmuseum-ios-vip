import Foundation
import Combine

enum WebServiceError: LocalizedError  {

    case urlError(Error)
    case badResponse
    case badStatusCode

    var errorDescription: String? {
        switch self {
        case let .urlError(error): return "Internal error: \(error)"
        case .badResponse: return "Recieved a bad response format from URLSession"
        case .badStatusCode: return "Recieved a bad status code"
        }
    }
}

public protocol WebService {
    func publisher<R: WebRequest>(forWebRequest webRequest: R) -> AnyPublisher<R.JSONType, Error>
}

public class WebServiceDefault {

    let webSession: WebSession
    let jsonDecoder: JSONDecoder

    public init(webSession: WebSession,
         jsonDecoder: JSONDecoder) {
        self.webSession = webSession
        self.jsonDecoder = jsonDecoder
    }
}

extension WebServiceDefault: WebService {
    public func publisher<R: WebRequest>(forWebRequest webRequest: R) -> AnyPublisher<R.JSONType, Error> {
        Just(webRequest)
            .convertToURLRequest()
            .setFailureType(to: Error.self)
            .flatMap {
                self.webSession.dataTaskPublisher(for: $0)
                    .mapError { WebServiceError.urlError($0) }}
            .processRespsonse()
            .decode(type: R.JSONType.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func processRespsonse() -> AnyPublisher<Data, Error> {
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

private extension Publisher where Output: WebRequest {
    func convertToURLRequest() -> AnyPublisher<URLRequest, Self.Failure> {
        map {
            URLRequest(url: $0.url)
        }
        .eraseToAnyPublisher()
    }
}
