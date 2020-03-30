import Foundation
import Utils
import RxSwift

public protocol ArtRepository {
    func fetchArts() -> Observable<[Art]>
}

public final class ArtRepositoryDefault: ArtRepository {

    private let localRepository: ArtRepositoryLocal
    private let remoteRepository: ArtRepositoryRemote

    init(localRepository: ArtRepositoryLocal,
         remoteRepository: ArtRepositoryRemote) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }

    public func fetchArts() -> Observable<[Art]> {
        Observable.just([])
    }
}









internal class ArtRepositoryRemote: ArtRepository {

    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func fetchArts() -> Observable<[Art]> {
        apiService.response(forWebRequest: CollectionAPIRequest())
            .map { $0.artJSONs }
    }
}






internal class ArtRepositoryLocal: ArtRepository {
    func fetchArts() -> Observable<[Art]> {
        Observable.just([])
    }
}
