
import Foundation
import Utils

public protocol Art {
    var id: String{get}
    var title: String{get}
    var artist: String{get}
    var imageUrl: URL{get}
}

internal protocol ArtFactory {
    func createArts(fromJSONData data:Data) throws -> [Art]
}

private enum LocalError: String, LocalizedError{
    case jsonDecodingFailure
}

internal class ArtFactoryDefault{
    let jsonDecoderService: JSONDecoderService
    init(jsonDecoderService: JSONDecoderService){
        self.jsonDecoderService = jsonDecoderService
    }
}

extension ArtFactoryDefault: ArtFactory {

    func createArts(fromJSONData data: Data) throws -> [Art] {
        do {
            let rootObject = try jsonDecoderService.decode(RootObject.self, from: data)
            return rootObject.artObjects
        } catch {
            throw LocalError.jsonDecodingFailure
        }
    }
}

private struct RootObject: Decodable {
    struct ArtObject: Art, Decodable {
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

    let artObjects: [ArtObject]

    private enum CodingKeys: String, CodingKey {
        case artObjects = "artObjects"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artObjects = try container.decode([ArtObject].self, forKey: .artObjects)
    }
}
