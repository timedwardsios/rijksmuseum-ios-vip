
import Foundation
import Kit
import Utils

protocol ListingInteracting {
    func loadArt()
}

protocol ListingPresenting {
    func didLoadArt(_ art:Art)
}

protocol ListingDisplaying: class {
    func displayImageURL(_ url:URL)
}
