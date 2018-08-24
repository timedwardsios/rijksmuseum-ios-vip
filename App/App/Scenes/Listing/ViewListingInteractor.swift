
import UIKit
import Services
import Utilities

class ViewListingInteractor: ViewListingDataStore{
    let presenter: ViewListingPresenterInterface
    let artDetailsService: ArtDetailsServiceInterface
    init(presenter:ViewListingPresenterInterface,
         artDetailsService:ArtDetailsServiceInterface) {
        self.presenter = presenter
        self.artDetailsService = artDetailsService
    }
}

extension ViewListingInteractor: ViewListingInteractorInterface {
    //
}

private extension ViewListingInteractor {
    //
}
