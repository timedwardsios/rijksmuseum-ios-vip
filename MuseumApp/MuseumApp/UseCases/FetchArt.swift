import MuseumDomain
import Utils
import RxSwift

public protocol ArtController {
    func fetchArts() -> Observable<[Art]>
    func getArt(withID: String) -> Observable<Art>
}

public class ArtControllerDefault {
    let appState: AppState
    let webService: APIService

    var cache = [Art]()

    init(appState: AppState,
         webService: APIService) {
        self.appState = appState
        self.webService = webService
    }
}

extension ArtControllerDefault: ArtController {
    public func fetchArts() -> Observable<[Art]> {
        webService.response(forWebRequest: CollectionWebRequest())
            .map { $0.artJSONs }
    }

    public func getArt(withID: String) -> Observable<Art> {
        <#code#>
    }
}

// todo, add cache to this class and fix details
// fix dependency management, caches need to be shared accross classes

protocol UseCase {
    AssociatedType ParameterType
    AssociatedType ReturnType
    func execute9)
}

final class FetchArtUseCase {

}
