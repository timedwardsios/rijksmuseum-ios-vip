import Foundation
import TimKit

internal protocol ArtistFactory {
    func constructArtists(fromJSONData data: Data) throws -> [Artist]
}

internal class ArtistFactoryDefault {

    let jsonDecoderService: JSONDecoderService

    init(jsonDecoderService: JSONDecoderService) {
        self.jsonDecoderService = jsonDecoderService
    }
}

extension ArtistFactoryDefault: ArtistFactory {

    func constructArtists(fromJSONData data: Data) throws -> [Artist] {
        return try artistsResultFromJSONData(data)
    }
}

private extension ArtistFactoryDefault {

    func artistsResultFromJSONData(_ data: Data) throws -> [Artist] {

        let rootJSON = try rootJSONFromData(data)

        let artists = artistsFromRootJSON(rootJSON)

        return artists
    }

    func rootJSONFromData(_ data: Data) throws -> RootJSON {
        return try jsonDecoderService.decode(RootJSON.self, from: data)
    }

    func artistsFromRootJSON(_ rootJSON: RootJSON) -> [Artist] {
        return rootJSON.artists
    }
}

private struct RootJSON: Decodable {

    let artists: [ArtistJSON]

    private enum CodingKeys: String, CodingKey {
        case artists
        case persons
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let allArtists = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .artists)
        artists = try allArtists.decode([ArtistJSON].self, forKey: .persons)
    }
}

private struct ArtistJSON: Artist, Decodable {

    var remoteId: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case remoteId = "id"
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.remoteId = try container.decode(Int.self, forKey: .remoteId)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
