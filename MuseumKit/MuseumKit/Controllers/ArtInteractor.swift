import Foundation
import TimKit
import Combine

// [NOUN]Interactor
public protocol ArtInteractor {
    func loadArt() -> AnyCancellable
}

struct ArtInteractorDefault {

    let museumWebService: MuseumWebService

    let state: State

    init(museumWebService: MuseumWebService,
         state: State) {
        self.museumWebService = museumWebService
        self.state = state
    }
}

extension ArtInteractorDefault: ArtInteractor {
    func loadArt() -> AnyCancellable {
        self.museumWebService.fetchArt().sink(receiveCompletion: {
            if case let .failure(error) = $0 {
                print(error.localizedDescription)
            }
        }, receiveValue: {
            self.state.arts = $0
        })
    }
}
