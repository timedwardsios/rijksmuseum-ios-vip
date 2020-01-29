import Foundation
import MuseumKit
import TimKit
import Combine

class PortfolioViewModel {

    @Published var viewDidAppear = false

    @Published var pullToRefreshIsRefreshing = false

    @Published var imageURLs = [URL]()

    @Published var alert: Alert?

    private var tokens = Set<AnyCancellable>()

    let artController: ArtController
    init(artController: ArtController) {
        self.artController = artController
        bind()
    }
}

private extension PortfolioViewModel {

    func bind() {
        $viewDidAppear
            .merge(with: $pullToRefreshIsRefreshing)
            .scan(false, { $0 != $1 })
            .filter { $0 == true }
            .map {_ in }
            .sink(receiveValue: updateArts)
            .store(in: &tokens)
    }

    func updateArts() {
        artController.fetchArt()
            .map { $0.map { $0.imageURL } }
            .handleEvents(receiveSubscription: { _ in
                self.pullToRefreshIsRefreshing = true
            }, receiveCompletion: {
                self.pullToRefreshIsRefreshing = false
                if case let .failure(error) = $0 {
                    self.alert = .error(error) {
                        self.alert = nil
                    }
                }
            }, receiveCancel: {
                self.pullToRefreshIsRefreshing = false
            })
            .replaceError(with: [])
            .assign(to: \PortfolioViewModel.imageURLs, on: self)
            .store(in: &tokens)
    }

    func selectArt(atIndex index: Int) {
        //        if let art = arts[optionalAt: index] {
        //            router.routeToArtDetails(forArt: art)
        //        }
    }
}
