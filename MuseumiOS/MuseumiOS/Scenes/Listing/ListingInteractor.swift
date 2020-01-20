import UIKit
import MuseumKit
import TimKit

class ListingInteractor {

    private let presenter: ListingPresenting
    private let art: Art

    init(presenter: ListingPresenting,
         art: Art) {
        self.presenter = presenter
        self.art = art
    }
}

extension ListingInteractor: ListingInteracting {
    func loadArt() {
        presenter.didLoadArt(art)
    }
}
