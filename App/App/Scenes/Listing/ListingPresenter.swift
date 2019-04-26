
import UIKit
import Services
import Utils

class ListingPresenter {
    var displayViewModel: ((ListingViewModel)->Void)?

    init(displayViewModel: ((ListingViewModel)->Void)? = nil) {
        self.displayViewModel = displayViewModel
    }
}

extension ListingPresenter {
    func presentResponse(response: ListingResponse) {
        switch response {
        case .didLoadArt(let art):
            displayViewModel?(.imageUrl(art.imageUrl))
        }
    }
}
