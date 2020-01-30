import Foundation
import MuseumKit
import TimKit
import Combine

class PortfolioViewModel {

    @Published private(set) var isLoading = false

    let alertPublisher = PassthroughSubject<Alert, Never>()

    let artController: ArtController
    init(artController: ArtController) {
        self.artController = artController
    }

    lazy var updateItems = artController.fetchArt()
        .map { $0.map { PortfolioCellModel(art: $0) } }
        .handleEvents(receiveSubscription: { _ in
            self.isLoading = true
        }, receiveCompletion: {
            self.isLoading = false

            if case let .failure(error) = $0 {
                self.alertPublisher.send(.error(error))
            }
        }, receiveCancel: {
            self.isLoading = false
        })
        .replaceError(with: [])
        .eraseToAnyPublisher()
}
