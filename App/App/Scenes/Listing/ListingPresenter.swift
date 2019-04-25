
import UIKit
import Services
import Utils

class ListingPresenter {
    weak var view: ListingView?

    init(view: ListingView? = nil) {
        self.view = view
    }
}

extension ListingPresenter: ListingPresentating {
    func loadArtResponse(_ response: Listing.LoadArt.Response) {
        view?.loadArtViewModel(.init(imageUrl: response.art.imageUrl))
    }
}
