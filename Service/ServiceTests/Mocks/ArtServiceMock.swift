
import Foundation
@testable import Service

class ArtServiceMock: ArtService {

    var resultToReturn: Result<[Art], Error>

    init(resultToReturn: Result<[Art], Error>) {
        self.resultToReturn = resultToReturn
    }

    var fetchArtArgs = 0

    func fetchArt(completion: @escaping (Result<[Art], Error>) -> Void) {
        fetchArtArgs += 1
        completion(resultToReturn)
    }
}
