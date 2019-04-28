
import Foundation
import Utils
@testable import Kit

class ArtFactorySpy: ArtFactory {

    var createArtsResult: Result<[Art], Error>

    init(createArtsResult: Result<[Art], Error>) {
        self.createArtsResult = createArtsResult
    }

    var createArtsArgs = [Data]()

    func arts(fromJSONData data: Data) throws -> [Art] {
        createArtsArgs.append(data)
        return try createArtsResult.get()
    }
}
