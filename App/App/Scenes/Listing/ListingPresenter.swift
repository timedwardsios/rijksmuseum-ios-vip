import UIKit
import Kit
import Utils

class ListingPresenter {

    private weak var display: ListingDisplaying?

    init(display: ListingDisplaying) {
        self.display = display
    }
}

extension ListingPresenter: ListingPresenting {
    func didLoadArt(_ art: Art) {
        let imageURL = getImageURLFromArt(art)
        display?.displayImageURL(imageURL)
    }
}

private extension ListingPresenter {

    func getImageURLFromArt(_ art: Art) -> URL {
        return art.imageURL
    }
}
