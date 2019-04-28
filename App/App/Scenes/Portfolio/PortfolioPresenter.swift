import Kit
import Utils

class PortfolioPresenter {

    private weak var display: PortfolioDisplaying?

    init(display: PortfolioDisplaying) {
        self.display = display
    }
}

extension PortfolioPresenter: PortfolioPresenting {

    func didBeginLoading() {
        display?.displayIsLoading(true)
    }

    func didFetchArts(_ arts: [Art]) {
        display?.displayIsLoading(false)
        let imageURLs = getImageURLsFromArts(arts)
        display?.displayImageURLs(imageURLs)
    }

    func didError(_ error: Error) {
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
