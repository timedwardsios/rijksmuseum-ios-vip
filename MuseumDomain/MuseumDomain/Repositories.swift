import Foundation

public struct Repositories {

    public let museumWebRepository: MuseumWebRepository

    public init() {
        self.museumWebRepository = MuseumWebRepositoryDefault(
            config: MuseumWebRepositoryConfig(),
            webSession: URLSession.shared,
            jsonDecoder: .init()
        )
    }
}
