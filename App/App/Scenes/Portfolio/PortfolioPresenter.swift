
import Services
import Utils

class PortfolioPresenter{
    var display: ((PortfolioViewModel)->Void)?

    init(display: ((PortfolioViewModel)->Void)? = nil) {
        self.display = display
    }
}

extension PortfolioPresenter {

    func present(response: PortfolioResponse) {
        switch response {
        case .didBeginLoading:
            display?(.isLoading(true))
        case .didFetchArts(let arts):
            display?(.isLoading(false))
            let imageUrls = arts.map({$0.imageUrl})
            display?(.imageUrls(imageUrls))
        case .didError(let error):
            display?(.errorAlertMessage(error.localizedDescription))
        }
    }
}
