import Foundation
import Utils

// core provides data access and model

public struct Repositories {

    public let artRepository: ArtRepository

    public init() {

        let artAPIService = APIServiceDefault(
            apiConfig: RijkmuseumAPIConfig(),
            urlSession: .shared,
            jsonDecoder: JSONDecoder()
        )

        self.artRepository = ArtRepositoryDefault(
            localRepository: ArtRepositoryLocal(),
            remoteRepository: ArtRepositoryRemote(
                apiService: artAPIService
            )
        )
    }
}
