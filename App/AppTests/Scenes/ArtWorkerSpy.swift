
import Foundation
import Utils
@testable import Services

class ArtWorkerSpy: ArtWorker {

    var fetchArtResult: Result<[Art], Error>

    init(fetchArtResult: Result<[Art], Error>) {
        self.fetchArtResult = fetchArtResult
    }

    var fetchArtArgs = 0

    func fetchArt(completion: @escaping (Result<[Art], Error>) -> Void) {
        fetchArtArgs += 1
        completion(fetchArtResult)
    }
}
