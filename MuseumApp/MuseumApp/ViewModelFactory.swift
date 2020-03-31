import MuseumCore

public class ViewModelFactory {

    private let useCaseFactory: UseCaseFactory

    public init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }

    public func artCollectionViewModel() -> ArtCollectionViewModel {
        .init(fetchArt: useCaseFactory.fetchArts)
    }

    public func artDetailsViewModel(art: Art) -> ArtDetailsViewModel { .init(art: art) }

    public func appViewModel() -> AppViewModel { .init() }
}
