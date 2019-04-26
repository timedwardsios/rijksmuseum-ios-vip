
import UIKit
import Services
import Utils

class ListingInteractor {

    let presenter: ListingPresenting
    let art: Art

    init(presenter: ListingPresenting,
         art:Art) {
        self.presenter = presenter
        self.art = art
    }
}

extension ListingInteractor: ListingInteracting {
    func loadArt() {
        presenter.didLoadArt(art)
    }
}
