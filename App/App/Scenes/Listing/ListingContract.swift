
import Foundation
import Services
import Utils

enum ListingRequest {
    case loadArt
}

enum ListingResponse {
    case didLoadArt(Art)
}

enum ListingViewModel {
    case imageUrl(URL)
}
