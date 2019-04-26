
@testable import App

class PortfolioDisplaySpy: PortfolioDisplaying {
    var displayViewModelArgs = [PortfolioViewModel]()
    func displayViewModel(_ viewModel: PortfolioViewModel) {
        displayViewModelArgs.append(viewModel)
    }
}

extension PortfolioViewModel: Equatable {
    public static func == (lhs: PortfolioViewModel, rhs: PortfolioViewModel) -> Bool {
        switch (lhs, rhs) {
        case (.isLoading(let isLoadingLeft), .isLoading(let isLoadingRight)):
            return isLoadingLeft == isLoadingRight
        case (.imageUrls(let imageUrlsLeft), .imageUrls(let imageUrlsRight)):
            return imageUrlsLeft == imageUrlsRight
        case (.errorAlertMessage(let messageLeft), .errorAlertMessage(let messageRight)):
            return messageLeft == messageRight
        default:
            return false
        }
    }
}
