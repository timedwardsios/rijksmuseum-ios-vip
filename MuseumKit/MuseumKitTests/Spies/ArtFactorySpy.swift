import Foundation
import TimKit
@testable import MuseumKit

class ArtFactorySpy: ArtsFactory {

    var artsResult: Result<[Art], Error>

    init(artsResult: Result<[Art], Error>) {
        self.artsResult = artsResult
    }

    var artsArgs = [Data]()

    func arts(fromJSONData data: Data) -> Result<[Art], Error> {
        artsArgs.append(data)
        return artsResult
    }
}
