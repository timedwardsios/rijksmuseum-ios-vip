import Foundation
import Combine

public protocol ArtRepository {
    func getArts() -> AnyPublisher<[Art], Error>
}

public final class ArtRepositoryDefault: ArtRepository {

    private var arts = [Art]()

    private let rijkmuseumWebService: RijkmuseumWebService

    init(artWebService: RijkmuseumWebService) {
        self.rijkmuseumWebService = artWebService
    }

    public func getArts() -> AnyPublisher<[Art], Error> {
        rijkmuseumWebService.performRequest(CollectionWebRequest())
            .map { $0.artJSONs }
            .eraseToAnyPublisher()
    }
}
