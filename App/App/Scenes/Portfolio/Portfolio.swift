
import Foundation
import Service
import Utils

protocol PortfolioInteracting {
    func processFetchArtsRequest(_ request:Portfolio.FetchArts.Request)
    func processSelectArtRequest(_ request:Portfolio.SelectArt.Request)
}

protocol PortfolioPresentating : class {
    func presentFetchArtsResponse(_ response:Portfolio.FetchArts.Response)
    func presentSelectArtResponse(_ response:Portfolio.SelectArt.Response)
}

protocol PortfolioDisplaying : class {
    func displayFetchArtsViewModel(_ viewModel:Portfolio.FetchArts.ViewModel)
    func displaySelectArtViewModel(_ viewModel:Portfolio.SelectArt.ViewModel)
}

protocol PortfolioDataStoring {
    var selectedArt: Art? {get}
}

protocol PortfolioRouting {
    func routeToListing()
}

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
}
