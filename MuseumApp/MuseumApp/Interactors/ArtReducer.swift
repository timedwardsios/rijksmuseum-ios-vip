import TimKit
import Foundation
import MuseumKit
import Combine

public protocol ArtInteractor {
    func fetchArts() -> AnyCancellable
}

class ArtInteractorDefault {

    let appState: AppState
    let museumWebService: MuseumWebService

    init(appState: AppState,
         museumWebService: MuseumWebService) {
        self.appState = appState
        self.museumWebService = museumWebService
    }
}

extension ArtInteractorDefault: ArtInteractor {

    func fetchArts() -> AnyCancellable {
        appState.arts = .loading
        return museumWebService.fetchArt()
            .assignToLoadable(to: \.arts, on: appState)
    }
}
