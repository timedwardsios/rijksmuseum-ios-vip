
import Foundation
@testable import Service

class ArtServiceMock: ArtService {

    var fetchArtReturnValue: Result<[Art], Error>

    init(fetchArtReturnValue: Result<[Art], Error>) {
        self.fetchArtReturnValue = fetchArtReturnValue
    }

    var fetchArtArgs = 0

    func fetchArt(completion: @escaping (Result<[Art], Error>) -> Void) {
        fetchArtArgs += 1
        completion(fetchArtReturnValue)
    }
}
