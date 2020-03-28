import Utils
import MuseumDomain
import Combine

public protocol ArtController {
    func fetchArts() -> AnyCancellable
}

class ArtControllerDefault {

    let appState: AppState
    let webService: WebService

    init(appState: AppState,
         webService: WebService = .init()) {
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
