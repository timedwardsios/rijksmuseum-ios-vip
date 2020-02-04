import TimKit
import Foundation
import MuseumKit
import Combine

// [NOUN]Interactor
public protocol ArtInteractor {
    func loadArt() -> AnyCancellable
}

class ArtInteractorDefault {

    let museumWebService: MuseumWebService

    let appState: AppState

    init(museumWebService: MuseumWebService,
         appState: AppState) {
        self.museumWebService = museumWebService
        self.appState = appState
    }
}

extension ArtInteractorDefault: ArtInteractor {
    func loadArt() -> AnyCancellable {
        self.museumWebService.fetchArt().sink(receiveCompletion: {
            if case let .failure(error) = $0 {
                print(error.localizedDescription)
            }
        }, receiveValue: {
            self.appState.arts = $0
        })
    }
}
