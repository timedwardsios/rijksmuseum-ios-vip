import TimKit
import Foundation
import MuseumKit
import Combine

public protocol ArtReducer {
    func allArts() -> AnyPublisher<[Art], Error>
}

class ArtReducerDefault {

    let museumWebService: MuseumWebService

    init(museumWebService: MuseumWebService) {
        self.museumWebService = museumWebService
    }
}

extension ArtReducerDefault: ArtReducer {

    func allArts() -> AnyPublisher<[Art], Error> {
        museumWebService
            .fetchArt()
            .eraseToAnyPublisher()
    }
}
