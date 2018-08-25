
import UIKit
import Service
import Utils

class ListingInteractor: ListingDataStore{
    let presenter: ListingPresenterInterface
    let artDetailsService: ArtDetailsServiceInterface
    let art: Art
    init(presenter:ListingPresenterInterface,
         artDetailsService:ArtDetailsServiceInterface,
         art:Art) {
        self.presenter = presenter
        self.artDetailsService = artDetailsService
        self.art = art
    }
}

extension ListingInteractor: ListingInteractorInterface {}

private extension ListingInteractor {}
