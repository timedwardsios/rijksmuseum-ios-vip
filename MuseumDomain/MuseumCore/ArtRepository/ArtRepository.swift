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
        Observable.of(
            Observable.just(arts),
            artWebService.performRequest(CollectionWebRequest())
                .map { $0.artJSONs }
                .do(onNext: {
                    self.arts = $0
                })
            )
            .merge()
    }
}
