import Foundation
@testable import App

class ListingDisplaySpy: ListingDisplaying {

    var displayImageURLArgs = [URL]()

    func displayImageURL(_ url: URL) {
        displayImageURLArgs.append(url)
    }
}
