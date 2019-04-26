
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

enum PortfolioRoute {
    case listing
}

protocol PortfolioDataStore {
    var selectedArt: Art? {get}
}
