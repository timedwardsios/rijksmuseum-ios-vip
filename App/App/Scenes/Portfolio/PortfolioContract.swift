
import Foundation
import Services
import Utils

protocol PortfolioInteracting {
    func processRequest(_ request: PortfolioRequest)
}

protocol PortfolioPresenting {
    func presentResponse(_ response: PortfolioResponse)
}

protocol PortfolioDisplaying: class {
    func displayViewModel(_ viewModel: PortfolioViewModel)
}

protocol PortfolioRouting {
    func routeToListing()
}

protocol PortfolioDataStore {
    var selectedArt: Art? {get}
}

enum PortfolioRequest {
    case fetchArts
    case selectArt(index: Int)
}

enum PortfolioResponse {
    case didBeginLoading
    case didFetchArts([Art])
    case didError(Error)
}

enum PortfolioViewModel {
    case isLoading(Bool)
    case imageUrls([URL])
    case errorAlertMessage(String)
}
