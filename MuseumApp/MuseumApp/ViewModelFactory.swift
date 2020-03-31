import MuseumCore

public protocol ViewModelFactory: UseCaseFactory {}

public extension ViewModelFactory {

    func resolve() -> ArtCollectionViewModel {
        .init(fetchArt: resolve())
    }

    func resolve(art: Art) -> ArtDetailsViewModel { .init(art: art) }

    func resolve() -> AppViewModel { .init() }
}
