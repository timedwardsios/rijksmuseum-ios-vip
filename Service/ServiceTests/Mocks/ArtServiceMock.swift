
import Foundation
@testable import Service

class ArtServiceMock: ArtService {
    func fetchArt(completion: @escaping (Result<[Art], Error>) -> Void) {}
}
