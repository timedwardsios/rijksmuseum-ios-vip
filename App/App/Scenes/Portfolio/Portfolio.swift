
import Foundation
import Services
import Utils

protocol PortfolioInteracting {
    func processFetchArtsRequest(_ request: Portfolio.FetchArts.Request)
    func processSelectArtRequest(_ request: Portfolio.SelectArt.Request)
}

protocol PortfolioPresentating : class {
    func presentFetchArtsResponse(_ response: Portfolio.FetchArts.Response)
}

protocol PortfolioDisplaying : class {
    func displayFetchArtsViewModel(_ viewModel: Portfolio.FetchArts.ViewModel)
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
    }
}
