import Foundation
import MuseumKit
import TimKit

class PortfolioPresenter {
    weak var display: PortfolioDisplaying?
}

extension PortfolioPresenter: PortfolioPresenting {

    func presentLoading() {
        display?.displayIsLoading(true)
    }

    func presentArts(_ arts: [Art]) {
        display?.displayIsLoading(false)
        let imageURLs = getImageURLsFromArts(arts)
        display?.displayImageURLs(imageURLs)
    }

    func presentError(_ error: Error) {
        display?.displayIsLoading(false)
        let errorMessage = getErrorMessageFromError(error)
        display?.displayErrorMessage(errorMessage)
    }
}

private extension PortfolioPresenter {

    func getImageURLsFromArts(_ arts: [Art]) -> [URL] {
        return arts.map({$0.imageURL})
    }

    func getErrorMessageFromError(_ error: Error) -> String {
        return error.localizedDescription
    }
}
