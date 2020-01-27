import Foundation
import MuseumKit
import TimKit

protocol PortfolioInteracting {
    func fetchArts()
    func selectArt(atIndex index: Int)
}

protocol PortfolioPresenting {
    func presentLoading()
    func presentArts(_ arts: [Art])
    func presentError(_ error: Error)
}

protocol PortfolioDisplaying: class {
    func displayIsLoading(_ isLoading: Bool)
    func displayImageURLs(_ urls: [URL])
    func displayErrorMessage(_ message: String)
}

protocol PortfolioRouter {
    func displayDetailsForArt(_ art: Art)
}
