
import UIKit
import Service
import Utils

class ListingInteractor: ListingDataStore{

    let presenter: ListingPresentating
    let art: Art

    init(presenter: ListingPresentating,
         art:Art) {
        self.presenter = presenter
        self.art = art
    }
}

extension ListingInteractor: ListingInteracting {
    func loadArtRequest(_ request: Listing.LoadArt.Request) {
        presenter.loadArtResponse(.init(art: art))
    }
}
