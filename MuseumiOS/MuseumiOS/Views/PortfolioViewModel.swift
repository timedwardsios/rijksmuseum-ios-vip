import Foundation
import MuseumKit
import TimKit
import Combine

extension PortfolioView {
    class Model {

//        @Published private(set) var isLoading = false

        let artInteractor: ArtInteractor

        init(artInteractor: ArtInteractor) {
            self.artInteractor = artInteractor
        }

        private var tokens = Set<AnyCancellable>()

        func refreshArts() {
            artInteractor.loadArt()
                .store(in: &tokens)
        }

        // to fix load state, wrap the State.Art in a loadable thing which can then update UI

//        lazy var updateItems = artin.fetchArt()
//            .handleEvents(receiveSubscription: { _ in
//                self.isLoading = true
//            }, receiveCompletion: {
//                self.isLoading = false
//
//                if case let .failure(error) = $0 {
//                    self.alertPublisher.send(.error(error))
//                }
//            }, receiveCancel: {
//                self.isLoading = false
//            })
//            .eraseToAnyPublisher()
    }
}
