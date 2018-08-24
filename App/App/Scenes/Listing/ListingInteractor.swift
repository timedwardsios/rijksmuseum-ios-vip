
import UIKit
import Services
import Utilities

class ListingInteractor: ListingDataStore{
    let presenter: ListingPresenterInterface
    let artDetailsService: ArtDetailsServiceInterface
    init(presenter:ListingPresenterInterface,
         artDetailsService:ArtDetailsServiceInterface) {
        self.presenter = presenter
        self.artDetailsService = artDetailsService
    }
}

extension ListingInteractor: ListingInteractorInterface {
    //
}

private extension ListingInteractor {
    //
}
