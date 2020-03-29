@testable import MuseumDomain
import Foundation
import Utils

class ArtistFactorySpy: ArtistFactory {

    var artistsResult: Result<[ArtistMock], Error>

    var artistsArgs = [Data]()

    init(artistsResult: Result<[ArtistMock], Error>) {
        self.artistsResult = artistsResult
    }

    func constructArtists(fromJSONData data: Data) throws -> [Artist] {
        artistsArgs.append(data)
        return try artistsResult.get()
    }
}
