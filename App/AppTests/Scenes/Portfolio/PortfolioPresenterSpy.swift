
import Services
@testable import App

class PortfolioPresenterSpy: PortfolioPresenting {

    var didBeginLoadingArgs = 0
    var didFetchArtsArgs = [[Art]]()
    var didErrorArgs = [Error]()

    func didBeginLoading() {
        didBeginLoadingArgs += 1
    }

    func didFetchArts(_ arts: [Art]) {
        didFetchArtsArgs.append(arts)
    }

    func didError(_ error: Error) {
        didErrorArgs.append(error)
    }
}
