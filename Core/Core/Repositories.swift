import Foundation

public struct Repositories {

    public let artRepository: ArtRepository

    public init(services: Services) {
        artRepository = ArtRepositoryDefault(artWebService: services.rijkmuseumWebService)
    }
}
