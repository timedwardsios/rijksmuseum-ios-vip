import Foundation
import Utils
import Combine

public class RijkmuseumWebService: WebService {

    struct Config: WebServiceConfig {

        let basePath = "https://www.rijksmuseum.nl/api/en"

        let queryItems: [URLQueryItem] = [
            .init(name: "key", value: "VV23OnI1"),
            .init(name: "format", value: "json"),
        ]
    }

    public let config: WebServiceConfig = Config()
    public let urlSession: URLSession
    public let jsonDecoder: JSONDecoder

    init(urlSession: URLSession,
         jsonDecoder: JSONDecoder) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
}
