import UIKit
import MuseumKit
import TimKit

class ListingPresenter {
    weak var display: ListingDisplaying?
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
