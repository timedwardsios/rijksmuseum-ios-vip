
import Foundation
import Utils

internal protocol ArtsFactory {
    func arts(fromJSONData data:Data) -> Result<[Art], Error>
}

internal class ArtsFactoryDefault{
    let jsonDecoderService: JSONDecoderService
    init(jsonDecoderService: JSONDecoderService){
        self.jsonDecoderService = jsonDecoderService
    }
}

extension ArtsFactoryDefault: ArtsFactory {

    func arts(fromJSONData data: Data) -> Result<[Art], Error> {
        return artsResultFromJSONData(data)
    }
}

private extension ArtsFactoryDefault {

    func artsResultFromJSONData(_ data:Data) -> Result<[Art], Error> {
        return Result{
            let rootJSON = try rootJSONFromData(data)
            return artsFromRootJSON(rootJSON)
        }
    }

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
        var imageURL: URL

        enum CodingKeys: String, CodingKey {
            case remoteId = "objectNumber"
            case title = "title"
            case artist = "principalOrFirstMaker"
            case imageDict = "webImage"
            case imageURL = "url"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .remoteId)
            self.title = try container.decode(String.self, forKey: .title)
            self.artist = try container.decode(String.self, forKey: .artist)
            let webImage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageDict)
            self.imageURL = try webImage.decode(URL.self, forKey: .imageURL)
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
