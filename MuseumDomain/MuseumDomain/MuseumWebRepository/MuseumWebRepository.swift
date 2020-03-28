import Foundation
import Utils
import Combine

public protocol MuseumWebRepository: WebRepository {
    func fetchArt() -> AnyPublisher<[Art], Error>
}

struct MuseumWebRepositoryDefault: MuseumWebRepository {

    let config: WebRepositoryConfig
    let webSession: WebSession
    let jsonDecoder: JSONDecoder

    init(config: WebRepositoryConfig, webSession: Utils.URLSession, jsonDecoder: JSONDecoder) {
        self.config = config
        self.webSession = webSession
        self.jsonDecoder = jsonDecoder
    }
}

extension MuseumWebRepositoryDefault {

    func fetchArt() -> AnyPublisher<[Art], Error> {
        performRequest(AllArt())
            .map { $0.artJSONs as [Art] }
            .eraseToAnyPublisher()
    }
}

private extension MuseumWebRepositoryDefault {


}






