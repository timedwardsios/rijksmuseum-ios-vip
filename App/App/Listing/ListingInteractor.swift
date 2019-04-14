
import UIKit
import Service
import Utils

class ListingInteractor: ListingDataStore{
    let output: ListingInteractorOutput
    let artDetailsService: ArtDetailsService
    let art: Art
    init(output:ListingInteractorOutput,
         artDetailsService:ArtDetailsService,
         art:Art) {
        self.output = output
        self.artDetailsService = artDetailsService
        self.art = art
    }
}

extension ListingInteractor: ListingInteractorInput {
    func performLoadArt(request: Listing.LoadArt.Request) {
        let response = Listing.LoadArt.Response(art: self.art)
        output.presentLoadArt(response: response)
    }
}

private extension ListingInteractor {}
