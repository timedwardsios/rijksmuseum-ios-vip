
import Foundation
import Services
import Utils

protocol ListingInteracting {
    func processRequest(_ request: ListingRequest)
}

protocol ListingPresenting {
    func presentResponse(_ response: ListingResponse)
}

protocol ListingDisplaying: class {
    func displayViewModel(_ viewModel: ListingViewModel)
}

enum ListingRequest {
    case loadArt
}

enum ListingResponse {
    case didLoadArt(Art)
}

enum ListingViewModel {
    case imageUrl(URL)
}
