import Foundation

public class RepositoryFactory {

    public let artRepository: ArtRepository

    public init(serviceFactory: ServiceFactory) {
        self.artRepository = ArtRepositoryDefault(artWebService: serviceFactory.artWebService)
    }
}
