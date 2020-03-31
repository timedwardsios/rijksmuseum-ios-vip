import Foundation

public protocol RepositoryFactory: ServiceFactory {}

public extension RepositoryFactory {
    func resolve() -> ArtRepository {
        ArtRepositoryDefault(artWebService: resolve())
    }
}
