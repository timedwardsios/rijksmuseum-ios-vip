import Foundation
import MuseumKit
import TimKit
import Combine

// refelects view state

// how to keep reference to art but only expose imageurls?

/*
 combine is for data sending
 events should be done through functions
 an alert is an event, it's not data
 the view is a function of the state
 the viewmodel holds the state
 we use protocols
 */


class PortfolioViewModel {

    typealias Item = StringIdentifiable & RemoteImage

    @Published private(set) var isRefreshing = false

    @Published private(set) var alert: Alert?

    @Published private(set) var items = [Item]()

    private var tokens = Set<AnyCancellable>()

    let artController: ArtController
    init(artController: ArtController) {
        self.artController = artController
    }
}

extension PortfolioViewModel {
    func updateArts() {
        artController.fetchArt()
            .map { $0 as [Item] }
            .handleEvents(receiveSubscription: { _ in
                self.isRefreshing = true
            }, receiveCompletion: {
                self.isRefreshing = false
                if case let .failure(error) = $0 {
                    self.alert = .error(error) {
                        self.alert = nil
                    }
                }
            }, receiveCancel: {
                self.isRefreshing = false
            })
            .replaceError(with: [])
            .assign(to: \.items, on: self)
            .store(in: &tokens)
    }

    func selectItem(withID id: String) {
        let item = items.first(where: { $0.id == id })
        print(item)
    }
}
