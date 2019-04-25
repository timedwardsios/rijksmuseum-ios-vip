
import Services
import Utils

class PortfolioPresenter{
    weak var view: PortfolioDisplaying?

    init(view: PortfolioDisplaying? = nil) {
        self.view = view
    }
}

extension PortfolioPresenter: PortfolioPresenting {
    func presentFetchArtsResponse(_ response: Portfolio.FetchArts.Response) {
        switch response.state {
        case .loading:
            view?.displayFetchArtsViewModel(.init(state: .loading))
        case .loaded(let arts):
            let imageUrls = arts.map({$0.imageUrl})
            view?.displayFetchArtsViewModel(.init(state: .loaded(imageUrls)))
        case .error(let error):
            view?.displayFetchArtsViewModel(.init(state: .error(error.localizedDescription)))
        }
    }
}
