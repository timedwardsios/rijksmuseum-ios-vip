
import Foundation
import Services
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
