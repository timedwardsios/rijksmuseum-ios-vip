
import UIKit
import Services
import Utilities

class ListingInteractor: ListingDataInterface{
    let presenter: ListingPresenterInterface
    let artDetailsService: ArtDetailsServiceInterface
    init(presenter:ListingPresenterInterface,
         artDetailsService:ArtDetailsServiceInterface) {
        self.presenter = presenter
        self.artDetailsService = artDetailsService
    }

    var art: Art?
}

extension ListingInteractor: ListingInteractorInterface {
    //
}

private extension ListingInteractor {
    //
}
