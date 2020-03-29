import Combine
import MuseumDomain
import Utils

public protocol ArtController {
    func fetchArts() -> AnyCancellable
}

class ArtControllerDefault {

    let appState: AppState
    let webService: WebService

    convenience init(appState: AppState) {
        self.init(appState: appState, webService: WebServiceDefault())
    }

    init(appState: AppState, webService: WebService) {
        self.appState = appState
        self.webService = webService
    }
}

extension ArtControllerDefault: ArtController {

    func fetchArts() -> AnyCancellable {
        appState.arts = .loading
        return webService.publisher(forWebRequest: CollectionWebRequest())
            .map { $0.artJSONs }
            .assignLoadable(to: \AppState.arts, on: appState)
    }
}
