import Foundation
import TimKit

extension Array where Element == Art {
    init(fromJSONData jsonData: Data,
         jsonDecoderService: JSONDecoderService = resolve()) throws {
        self = try jsonDecoderService.decode(RootJSON.self, from: jsonData).artJSONs
    }
}

private struct ArtJSON: Art, Decodable {

    var identifier: String
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
        self.identifier = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.artist = try container.decode(String.self, forKey: .artist)
        let webImage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageDict)
        self.imageURL = try webImage.decode(URL.self, forKey: .imageURL)
    }
}

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
