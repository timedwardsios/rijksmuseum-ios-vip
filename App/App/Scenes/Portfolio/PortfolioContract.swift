
import Foundation
import Services
import Utils

protocol PortfolioInteractor {
    func processRequest(_ request: PortfolioRequest)
}

protocol PortfolioPresenter {
    func presentResponse(_ response: PortfolioResponse)
}

protocol PortfolioDisplay : class {
    func displayViewModel(_ viewModel: PortfolioViewModel)
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

protocol PortfolioDataStoring {
    var selectedArt: Art? {get}
}

protocol PortfolioRouting {
    func routeToListing()
}
