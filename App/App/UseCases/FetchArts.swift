import Core
import Utils
import Combine

public protocol FetchArts {

    var artRepository: ArtRepository { get }

    func getArts() -> AnyPublisher<[Art], Error>
}

public extension FetchArts {
    func getArts() -> AnyPublisher<[Art], Error> {
        artRepository.getArts()
            .eraseToAnyPublisher()
    }
}
