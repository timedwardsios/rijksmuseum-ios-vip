import UIKit
import MuseumKit
import TimKit

class DetailsPresenter {
    weak var display: DetailsDisplaying?
}

extension DetailsPresenter: DetailsPresenting {
    func presentArt(_ art: Art) {
        let imageURL = getImageURLFromArt(art)
        display?.displayImageURL(imageURL)
    }
}

private extension DetailsPresenter {

    func getImageURLFromArt(_ art: Art) -> URL {
        return art.imageURL
    }
}
