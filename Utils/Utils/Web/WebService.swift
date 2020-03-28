import Foundation
import Combine

enum WebServiceError: LocalizedError  {

    case internalError(Error)
    case urlComponentsError
    case urlGenerationError
    case responseError
    case statusCodeError

    var errorDescription: String? {
        switch self {
        case let .internalError(error): return "Internal error: \(error)"
        case .urlComponentsError: return "Failed to create url components"
        case .urlGenerationError: return "Failed to generate url"
        case .responseError: return "Recieved a bad response format from URLSession"
        case .statusCodeError: return "Recieved a bad status code"
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
            .flatMap {
                self.webSession.dataTaskPublisher(for: $0)
                    .mapError { WebServiceError.internalError($0) }}
            .processRespsonse()
            .decode(type: R.JSONType.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func processRespsonse() -> AnyPublisher<Data, Error> {
        tryMap {
            guard let response = $0.1 as? HTTPURLResponse else {
                throw WebServiceError.responseError
            }
            guard 200..<300 ~= response.statusCode else {
                throw WebServiceError.statusCodeError
            }
            return $0.0
        }
        .eraseToAnyPublisher()
    }
}

private extension Publisher where Output: WebRequest {
    func convertToURLRequest() -> AnyPublisher<URLRequest, Error> {
        tryMap {

            guard var urlComponents = URLComponents(url: $0.url, resolvingAgainstBaseURL: true) else {
                throw WebServiceError.urlComponentsError
            }

            urlComponents.queryItems = $0.queryItems.map {URLQueryItem(name: $0, value: $1)}

            guard let url = urlComponents.url else {
                throw WebServiceError.urlGenerationError
            }

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = $0.httpMethod.rawValue
            urlRequest.allHTTPHeaderFields = $0.headers

            return urlRequest
        }
        .eraseToAnyPublisher()
    }
}
