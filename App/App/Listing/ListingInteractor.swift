
import UIKit
import Service
import Utils

class ListingInteractor: ListingDataStore{

    let presenter: ListingPresentating
    let artDetailsService: ArtDetailsService
    let art: Art

    init(presenter: ListingPresentating,
         artDetailsService:ArtDetailsService,
         art:Art) {
        self.presenter = presenter
        self.artDetailsService = artDetailsService
        self.art = art
    }
}

extension ListingInteractor: ListingInteracting {
    func loadArtRequest(_ request: Listing.LoadArt.Request) {
        presenter.loadArtResponse(.init(art: art))
    }
}
