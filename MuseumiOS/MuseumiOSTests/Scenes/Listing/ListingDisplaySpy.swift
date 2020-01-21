import Foundation
@testable import MuseumiOS

class ListingDisplaySpy: ListingDisplaying {

    var displayImageURLArgs = [URL]()

    func displayImageURL(_ url: URL) {
        displayImageURLArgs.append(url)
    }
}
