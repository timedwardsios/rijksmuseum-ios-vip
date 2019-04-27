
import UIKit
import Services
import Utils

class ListingPresenter {

    private weak var display: ListingDisplaying?

    init(display: ListingDisplaying){
        self.display = display
    }
}

extension ListingPresenter: ListingPresenting {
    func didLoadArt(_ art: Art) {
        display?.displayImageURL(art.imageUrl)
    }
}
