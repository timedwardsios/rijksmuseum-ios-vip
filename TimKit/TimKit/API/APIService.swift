import Foundation
import Combine

public protocol APIService {
    func publisher<T: APIOperation>(forAPIOperation apiOperation: T) -> AnyPublisher<T.DecodableType, Error>
}

class APIServiceDefault {

    let apiConfig: APIConfig
    let urlSession: URLSession
    let jsonDecoder: JSONDecoder

    init(apiConfig: APIConfig,
         urlSession: URLSession,
         jsonDecoder: JSONDecoder) {
        self.apiConfig = apiConfig
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
}

extension APIServiceDefault: APIService {
    func publisher<T: APIOperation>(forAPIOperation apiOperation: T) -> AnyPublisher<T.DecodableType, Error> {
        Just(apiOperation)
            .compactMap { URLRequest(fromAPIConfig: self.apiConfig, apiRequest: $0) }
            .setFailureType(to: URLError.self)
            .flatMap { self.urlSession.dataTaskPublisher(for: $0) }
            .map { $0.data }
            .decode(type: apiOperation.decodableType, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
