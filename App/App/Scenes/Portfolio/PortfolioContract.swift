
import Foundation
import Kit
import Utils

protocol PortfolioInteracting {
    func fetchArts()
    func selectArt(atIndex index: Int)
}

protocol PortfolioPresenting {
    func didBeginLoading()
    func didFetchArts(_ arts:[Art])
    func didError(_ error:Error)
}

protocol PortfolioDisplaying: class {
    func displayIsLoading(_ isLoading: Bool)
    func displayImageURLs(_ urls:[URL])
    func displayErrorMessage(_ message: String)
}

protocol PortfolioRouting {
    func routeToListing()
}

protocol PortfolioDataStore {
    var selectedArt: Art? {get}
}
