import MuseumCore

public class UseCaseFactory {

    let fetchArts: FetchArts

    public init(repositoryFactory: RepositoryFactory) {
        fetchArts = FetchArts(artRepository: repositoryFactory.artRepository)
    }
}
