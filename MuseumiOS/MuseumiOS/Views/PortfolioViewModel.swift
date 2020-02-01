import Foundation
import MuseumKit
import TimKit
import Combine

class PortfolioViewModel {

    let portfolioCellModels: AnyPublisher<[PortfolioCellModel], Never>

    @Published var searchText = ""

    private let artInteractor: ArtInteractor
    private var tokens: Set<AnyCancellable> = []
    init(state: State,
         artInteractor: ArtInteractor) {
        self.artInteractor = artInteractor

        portfolioCellModels = state.$arts
            .map { $0.map { PortfolioCellModel(art: $0) } }
            .eraseToAnyPublisher()
    }

    // interactor handles all work, this should be lightweight. Just stores tokens
    // get VC stuff out into VM
    // get VM stuff out into I

    func didPullToRefresh() {
        artInteractor.loadArt().store(in: &tokens)
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

//enum PortfolioEvent {
//    case didAppear
//    case didPullToRefresh
//    case didSearch(term: String)
//    case didSelect(cellModel: PortfolioCellModel)
//}
//
//extension PortfolioViewModel: SimpleSubscriber {
//    func recieve(_ input: PortfolioEvent) {
//
//    }
//}
