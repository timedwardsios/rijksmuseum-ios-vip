import UIKit
import MuseumKit
import TimKit

class DetailsInteractor {

    private let presenter: DetailsPresenting
    private let art: Art

    init(presenter: DetailsPresenting,
         art: Art) {
        self.presenter = presenter
        self.art = art
    }
}

extension DetailsInteractor: DetailsInteracting {
    func loadArt() {
        presenter.presentArt(art)
    }
}
