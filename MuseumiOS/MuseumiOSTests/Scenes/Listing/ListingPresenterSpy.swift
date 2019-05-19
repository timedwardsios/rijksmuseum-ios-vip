
@testable import App

class ListingPresenterSpy: ListingPresenting {

    var didLoadArtArgs = [Art]()

    func didLoadArt(_ art: Art) {
        didLoadArtArgs.append(art)

    }
}
