import Utils
import Foundation
import MuseumDomain
import Combine

public protocol ArtService {
    func updateArts() -> AnyCancellable
}

class ArtServiceDefault {

    let appState: AppState
    let museumWebRepository: MuseumWebRepository

    init(appState: AppState,
         museumWebRepository: MuseumWebRepository) {
        self.appState = appState
        self.museumWebRepository = museumWebRepository
    }
}

extension ArtServiceDefault: ArtService {

    func updateArts() -> AnyCancellable {
        appState.arts = .loading
        return museumWebRepository.fetchArt()
            .assignToLoadable(to: \.arts, on: appState)
    }
}
