
import Foundation
import Services
import Utils

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
