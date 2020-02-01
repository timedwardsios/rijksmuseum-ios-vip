import Foundation
import TimKit
import Combine

// [ENTITY / COMPANY]WebService
public protocol MuseumWebService: WebService {
    func fetchArt() -> AnyPublisher<[Art], Error>
}

// Service: provides something from web or cache, database etc.
// WebService: an abstract protocol for a service to hit REST APIs
// MuseumWebService: an abstract extension of WebService for simply Museum API calls
// MuseumWebServiceDefault: a concrete type for calling from interactors

struct MuseumWebServiceDefault: MuseumWebService {
    let config: WebServiceConfig, urlSession: URLSession, jsonDecoder: JSONDecoder
    init(config: WebServiceConfig, urlSession: URLSession, jsonDecoder: JSONDecoder) {
        self.config = config; self.urlSession = urlSession; self.jsonDecoder = jsonDecoder
    }
}

extension MuseumWebServiceDefault {
    func fetchArt() -> AnyPublisher<[Art], Error> {
        self.performRequest(AllArt())
            .map { $0.artJSONs as [Art] }
            .eraseToAnyPublisher()
    }
}

private extension MuseumWebServiceDefault {

    struct AllArt: WebRequest {

        let path = "/collection"

        let queryItems = [
            "ps": "100",
            "imgonly": "true",
            "s": "relevance"
        ]

        var jsonType = RootJSON.self
    }
}

struct MuseumAPIConfig: WebServiceConfig {
    var urlScheme: URLScheme = .https

    var hostname = "www.rijksmuseum.nl"

    var path = "/api/en"

    var queryItems = [
        "key": "VV23OnI1",
        "format": "json"
    ]
}







// TODO: Reconsider if types need to be protocols, can we simply use concrete types as our model?
private struct RootJSON: Decodable {

    let artJSONs: [ArtJSON]

    private enum CodingKeys: String, CodingKey {
        case artArray = "artObjects"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artJSONs = try container.decode([ArtJSON].self, forKey: .artArray)
    }
}

private struct ArtJSON: Art, Decodable {

    var id: String
    var title: String
    var artist: String
    var imageURL: URL

    enum CodingKeys: String, CodingKey {
        case artArray = "artObjects"
        case id = "objectNumber"
        case title = "title"
        case artist = "principalOrFirstMaker"
        case imageDict = "webImage"
        case imageURL = "url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.artist = try container.decode(String.self, forKey: .artist)
        let webImage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageDict)
        self.imageURL = try webImage.decode(URL.self, forKey: .imageURL)
    }
}
