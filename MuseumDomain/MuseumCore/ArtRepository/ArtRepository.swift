import Foundation
import Utils
import RxSwift

public protocol ArtRepository {
    func fetchArts() -> Observable<[Art]>
}

public final class ArtRepositoryDefault: ArtRepository {

    private var arts = [Art]()

    private let artWebService: WebService

    init(artWebService: WebService) {
        self.artWebService = artWebService
    }

    public func fetchArts() -> Observable<[Art]> {

        let artObserver = artWebService.performRequest(CollectionWebRequest())
            .map { $0.artJSONs as [Art] }

        return Observable.of(Observable.just(arts), artObserver)
            .merge()
    }
}
