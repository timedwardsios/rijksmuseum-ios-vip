
import Foundation
import Utils
@testable import Services

class ArtFactorySpy: ArtFactory {

    var createArtsResult: Result<[Art], Error>

    init(createArtsResult: Result<[Art], Error>) {
        self.createArtsResult = createArtsResult
    }

    var createArtsArgs = [Data]()

    func createArts(fromJSONData data: Data) throws -> [Art] {
        createArtsArgs.append(data)
        return try createArtsResult.get()
    }
}
