import Core

public typealias AllUseCases = FetchArts

public struct UseCases: AllUseCases {

    public let artRepository: ArtRepository

    public init(repositories: Repositories) {
        self.artRepository = repositories.artRepository
    }
}
