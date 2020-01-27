import Foundation
import MuseumKit
import TimKit

protocol DetailsInteracting {
    func loadArt()
}

protocol DetailsPresenting {
    func presentArt(_ art: Art)
}

protocol DetailsDisplaying: class {
    func displayImageURL(_ url: URL)
}
