import Foundation
import MuseumKit
import TimKit

protocol ListingInteracting {
    func loadArt()
}

protocol ListingPresenting {
    func didLoadArt(_ art: Art)
}

protocol ListingDisplaying: class {
    func displayImageURL(_ url: URL)
}
