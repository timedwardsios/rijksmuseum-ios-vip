
import UIKit
import Service
import Utils

class ListingInteractor: ListingDataStore{
    let presenter: ListingPresenterProtocol
    let artDetailsService: ArtDetailsServiceProtocol
    let art: Art
    init(presenter:ListingPresenterProtocol,
         artDetailsService:ArtDetailsServiceProtocol,
         art:Art) {
        self.presenter = presenter
        self.artDetailsService = artDetailsService
        self.art = art
    }
}

extension ListingInteractor: ListingInteractorProtocol {}

private extension ListingInteractor {}
