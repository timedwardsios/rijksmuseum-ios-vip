
@testable import App

class PortfolioPresenterSpy: PortfolioPresenting {
    var presentResponseArgs = [PortfolioResponse]()
    func presentResponse(_ response: PortfolioResponse) {
        presentResponseArgs.append(response)
    }
}

extension PortfolioResponse: Equatable {
    public static func == (lhs: PortfolioResponse, rhs: PortfolioResponse) -> Bool {
        switch (lhs, rhs) {
        case (.didBeginLoading, .didBeginLoading):
            return true
        case (.didFetchArts(let artsLeft), .didFetchArts(let artsRight)):
            if let artsLeft = artsLeft as? [ArtMock],
                let artsRight = artsRight as? [ArtMock],
                artsLeft == artsRight {
                return true
            }
            return false
        case (.didError, .didError):
            return true
        default:
            return false
        }
    }
}
