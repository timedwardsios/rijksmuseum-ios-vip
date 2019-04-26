
import UIKit
import Services
import Utils

class ListingInteractor {

    let presentResponse: (ListingResponse)->Void
    let art: Art

    init(presentResponse: @escaping (ListingResponse)->Void,
         art:Art) {
        self.presentResponse = presentResponse
        self.art = art
    }
}

extension ListingInteractor {
    func processRequest(request: ListingRequest) {
        presentResponse(.didLoadArt(art))
    }
}
