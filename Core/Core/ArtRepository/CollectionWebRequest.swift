import Foundation
import Utils

struct CollectionWebRequest: WebRequest {

    typealias ResponseJSONType = CollectionJSON

    var pathExtension = "/collection"

    let queryItems: [URLQueryItem] = [
        .init(name: "ps", value: "100"),
        .init(name: "imgonly", value: "true"),
        .init(name: "s", value: "relevance"),
    ]
}

struct CollectionJSON: Decodable {
    private enum CodingKeys: String, CodingKey {
        case artArray = "artObjects"
    }

    let artJSONs: [ArtJSON]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artJSONs = try container.decode([ArtJSON].self, forKey: .artArray)
    }
}

struct ArtJSON: Art, Decodable {
    enum CodingKeys: String, CodingKey {
        case artArray = "artObjects"
        case id = "objectNumber"
        case title
        case artist = "principalOrFirstMaker"
        case imageDict = "webImage"
        case imageURL = "url"
    }

    var id: String
    var title: String
    var artist: String
    var imageURL: URL

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        artist = try container.decode(String.self, forKey: .artist)
        let webImage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageDict)
        imageURL = try webImage.decode(URL.self, forKey: .imageURL)
    }
}
