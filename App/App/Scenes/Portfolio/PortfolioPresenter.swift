
import Services
import Utils

class PortfolioPresenter{
    weak var display: PortfolioDisplaying?

    init(display: PortfolioDisplaying? = nil){
        self.display = display
    }
}

extension PortfolioPresenter: PortfolioPresenting {

    func presentResponse(_ response: PortfolioResponse) {
        switch response {
        case .didBeginLoading:
            display?.displayViewModel(.isLoading(true))
        case .didFetchArts(let arts):
            display?.displayViewModel(.isLoading(false))
            let imageUrls = arts.map({$0.imageUrl})
            display?.displayViewModel(.imageUrls(imageUrls))
        case .didError(let error):
            display?.displayViewModel(.isLoading(false))
            display?.displayViewModel(.errorAlertMessage(error.localizedDescription))
        }
    }
}
