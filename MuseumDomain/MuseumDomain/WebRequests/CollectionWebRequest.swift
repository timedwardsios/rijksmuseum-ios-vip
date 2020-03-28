import Foundation
import Utils
import Combine

public struct CollectionWebRequest: WebRequest {

    public let url = URL(string: "https://www.rijksmuseum.nl/api/en/collection")!

    public let queryItems = [
        "key": "VV23OnI1",
        "format": "json",
        "ps": "100",
        "imgonly": "true",
        "s": "relevance"
    ]

    public let jsonType = RootJSON.self

    public init() {}
}

public struct RootJSON: Decodable {

    public let artJSONs: [ArtJSON]

    private enum CodingKeys: String, CodingKey {
        case artArray = "artObjects"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artJSONs = try container.decode([ArtJSON].self, forKey: .artArray)
    }
}

public struct ArtJSON: Art, Decodable {

    public var id: String
    public var title: String
    public var artist: String
    public var imageURL: URL

    enum CodingKeys: String, CodingKey {
        case artArray = "artObjects"
        case id = "objectNumber"
        case title = "title"
        case artist = "principalOrFirstMaker"
        case imageDict = "webImage"
        case imageURL = "url"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.artist = try container.decode(String.self, forKey: .artist)
        let webImage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageDict)
        self.imageURL = try webImage.decode(URL.self, forKey: .imageURL)
    }
}
