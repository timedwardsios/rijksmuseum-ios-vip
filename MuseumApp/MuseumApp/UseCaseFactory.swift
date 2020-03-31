import MuseumCore

public protocol UseCaseFactory: RepositoryFactory {}

public extension UseCaseFactory {

    func resolve() -> FetchArts {
        .init(artRepository: resolve())
    }
}
