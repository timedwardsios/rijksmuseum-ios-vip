
import Services
import Utils

class PortfolioPresenter{
    var displayViewModel: ((PortfolioViewModel)->Void)?

    init(displayViewModel: ((PortfolioViewModel)->Void)? = nil) {
        self.displayViewModel = displayViewModel
    }
}

extension PortfolioPresenter {

    func presentResponse(response: PortfolioResponse) {
        switch response {
        case .didBeginLoading:
            displayViewModel?(.isLoading(true))
        case .didFetchArts(let arts):
            displayViewModel?(.isLoading(false))
            let imageUrls = arts.map({$0.imageUrl})
            displayViewModel?(.imageUrls(imageUrls))
        case .didError(let error):
            displayViewModel?(.isLoading(false))
            displayViewModel?(.errorAlertMessage(error.localizedDescription))
        }
    }
}
