
import Foundation
@testable import App

class PortfolioDisplaySpy: PortfolioDisplaying {

    var displayIsLoadingArgs = [Bool]()
    var displayImageUrlsArgs = [[URL]]()
    var displayErrorMessageArgs = [String]()

    func displayIsLoading(_ isLoading: Bool) {
        displayIsLoadingArgs.append(isLoading)
    }

    func displayImageUrls(_ urls: [URL]) {
        displayImageUrlsArgs.append(urls)
    }

    func displayErrorMessage(_ message: String) {
        displayErrorMessageArgs.append(message)
    }
}
