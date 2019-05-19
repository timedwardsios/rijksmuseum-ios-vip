import Foundation
import TimKit
@testable import MuseumKit

class ArtistFactorySpy: ArtistFactory {

    var artistsResult: Result<[ArtistMock], Error>

    init(artistsResult: Result<[ArtistMock], Error>) {
        self.artistsResult = artistsResult
    }

    var artistsArgs = [Data]()

    func constructArtists(fromJSONData data: Data) throws -> [Artist] {
        artistsArgs.append(data)
        return try artistsResult.get()
    }
}
