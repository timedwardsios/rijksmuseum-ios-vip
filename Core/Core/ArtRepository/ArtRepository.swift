import Foundation
import Utils
import Combine

public protocol ArtRepository {
    func getArts() -> AnyPublisher<[Art], Error>
}

class ArtRepositoryDefault: WebRepository {

    public struct Config: WebRepositoryConfig {

        public static let basePath = "https://www.rijksmuseum.nl/api/en"

        public static let queryItems: [URLQueryItem] = [
            .init(name: "key", value: "VV23OnI1"),
            .init(name: "format", value: "json"),
        ]
    }

    let urlSession: URLSession
    let jsonDecoder: JSONDecoder

    init(urlSession: URLSession,
         jsonDecoder: JSONDecoder) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
}

extension ArtRepositoryDefault: ArtRepository {
    public func getArts() -> AnyPublisher<[Art], Error> {
        performRequest(CollectionWebRequest())
            .map { $0.artJSONs as [Art] }
            .eraseToAnyPublisher()
    }
}
