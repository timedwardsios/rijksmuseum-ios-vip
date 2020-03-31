import Foundation
import Utils
import RxSwift

class RijkmuseumWebService: WebService {

    struct Config: WebServiceConfig {

        let basePath = "https://www.rijksmuseum.nl/api/en"

        let queryItems: [URLQueryItem] = [
            .init(name: "key", value: "VV23OnI1"),
            .init(name: "format", value: "json"),
        ]
    }

    var apiConfig: WebServiceConfig = Config()
    let urlSession: URLSession
    let jsonDecoder: JSONDecoder

    init(urlSession: URLSession,
         jsonDecoder: JSONDecoder) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }

    func fetchArts() -> Observable<[Art]> {
        performRequest(CollectionWebRequest())
            .map { $0.artJSONs }
    }
}
