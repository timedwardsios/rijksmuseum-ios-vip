
import Foundation
import Utils

internal protocol ArtFactory {
    func arts(fromJSONData data:Data) throws -> [Art]
}

internal class ArtFactoryDefault{
    let jsonDecoderService: JSONDecoderService
    init(jsonDecoderService: JSONDecoderService){
        self.jsonDecoderService = jsonDecoderService
    }
}

extension ArtFactoryDefault: ArtFactory {

    func arts(fromJSONData data: Data) throws -> [Art] {
        let rootJSON = try rootJSONFromData(data)
        let arts = artsFromRootJSON(rootJSON)
        return arts
    }
}

private extension ArtFactoryDefault {

    func rootJSONFromData(_ data:Data) throws -> RootJSON {
        return try jsonDecoderService.decode(RootJSON.self, from: data)
    }

    func artsFromRootJSON(_ rootJSON: RootJSON) -> [Art] {
        return rootJSON.artJSONs
    }
}


private struct RootJSON: Decodable {

    struct ArtJSON: Art, Decodable {

        var id: String
        var title: String
        var artist: String
        var imageUrl: URL

        enum CodingKeys: String, CodingKey {
            case remoteId = "objectNumber"
            case title = "title"
            case artist = "principalOrFirstMaker"
            case imageDict = "webImage"
            case imageUrl = "url"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .remoteId)
            self.title = try container.decode(String.self, forKey: .title)
            self.artist = try container.decode(String.self, forKey: .artist)
            let webImage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageDict)
            self.imageUrl = try webImage.decode(URL.self, forKey: .imageUrl)
        }
    }

    let artJSONs: [ArtJSON]

    private enum CodingKeys: String, CodingKey {
        case artObjects = "artObjects"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artJSONs = try container.decode([ArtJSON].self, forKey: .artObjects)
    }
}
