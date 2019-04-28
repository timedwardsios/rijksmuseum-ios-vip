
import Foundation
@testable import App

class PortfolioDisplaySpy: PortfolioDisplaying {

    var displayIsLoadingArgs = [Bool]()
    var displayImageURLsArgs = [[URL]]()
    var displayErrorMessageArgs = [String]()

    func displayIsLoading(_ isLoading: Bool) {
        displayIsLoadingArgs.append(isLoading)
    }

    func displayImageURLs(_ urls: [URL]) {
        displayImageURLsArgs.append(urls)
    }

    func displayErrorMessage(_ message: String) {
        displayErrorMessageArgs.append(message)
    }
}
