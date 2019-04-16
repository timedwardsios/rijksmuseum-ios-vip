
import Foundation
import Service
import Utils

// VIP
protocol PortfolioInteracting {
    func fetchArtsRequest(_ request:Portfolio.FetchArts.Request)
    func selectArtRequest(_ request:Portfolio.SelectArt.Request)
}

protocol PortfolioPresentating : class {
    func fetchArtsResponse(_ response:Portfolio.FetchArts.Response)
    func selectArtResponse(_ response:Portfolio.SelectArt.Response)
}

protocol PortfolioView : class {
    func fetchArtsViewModel(_ viewModel:Portfolio.FetchArts.ViewModel)
    func selectArtViewModel(_ viewModel:Portfolio.SelectArt.ViewModel)
}

protocol PortfolioDataStore {
    var arts: [Art] {get}
    var selectedArt: Art? {get}
}

// scene
enum Portfolio {
    enum FetchArts {
        struct Request {}

        struct Response {
            let state: State<[Art], Error>
        }

        struct ViewModel {
            let state: State<[URL], String>
        }
    }

    enum SelectArt  {
        struct Request {
            let index: Int
        }

        struct Response {}

        struct ViewModel {}
    }

    static func build() -> PortfolioViewController {
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(presenter: presenter,
                                             artService: DependenciesDefault.artService)
        let view = PortfolioViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
