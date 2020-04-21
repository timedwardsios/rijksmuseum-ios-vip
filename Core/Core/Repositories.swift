import Foundation

public struct Repositories {

    public let artRepository: ArtRepository

    public init(urlSession: URLSession,
                jsonDecoder: JSONDecoder) {
        artRepository = ArtRepositoryDefault(urlSession: urlSession,
                                             jsonDecoder: jsonDecoder
        )
    }
}
