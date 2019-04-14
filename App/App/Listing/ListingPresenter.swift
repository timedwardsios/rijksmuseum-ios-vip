
import UIKit
import Service
import Utils

class ListingPresenter {
    weak var output: ListingPresenterOutput?
}

extension ListingPresenter: ListingPresenterInput{
    func presentLoadArt(response: Listing.LoadArt.Response) {
        let viewModel = Listing.LoadArt.ViewModel(imageUrl: response.art.imageUrl)
        output?.displayLoadArt(viewModel: viewModel)
    }
}

private extension ListingPresenter {}
