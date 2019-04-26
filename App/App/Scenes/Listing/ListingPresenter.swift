
import UIKit
import Services
import Utils

class ListingPresenter {
    weak var display: ListingDisplaying?

    init(display: ListingDisplaying? = nil){
        self.display = display
    }
}

extension ListingPresenter: ListingPresenting {
    func presentResponse(_ response: ListingResponse) {
        switch response {
        case .didLoadArt(let art):
            display?.displayViewModel(.imageUrl(art.imageUrl))
        }
    }
}
