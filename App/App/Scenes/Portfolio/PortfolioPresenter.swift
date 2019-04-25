
import Services
import Utils

class PortfolioPresenterDefault{
    weak var view: PortfolioDisplay?

    init(view: PortfolioDisplay? = nil) {
        self.view = view
    }
}

extension PortfolioPresenterDefault: PortfolioPresenter {

    func presentResponse(_ response: PortfolioResponse) {
        switch response {
        case .didBeginLoading:
            view?.displayViewModel(.isLoading(true))
        case .didFetchArts(let arts):
            view?.displayViewModel(.isLoading(false))
            let imageUrls = arts.map({$0.imageUrl})
            view?.displayViewModel(.imageUrls(imageUrls))
        case .didError(let error):
            view?.displayViewModel(.errorAlertMessage(error.localizedDescription))
        }
    }
}
