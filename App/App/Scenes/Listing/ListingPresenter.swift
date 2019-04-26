
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
    func didLoadArt(_ art: Art) {
        display?.displayImageURL(art.imageUrl)
    }
}
