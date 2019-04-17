
import Service
import Utils

class PortfolioPresenter{
    weak var view: PortfolioView?

    init(view: PortfolioView? = nil) {
        self.view = view
    }
}

extension PortfolioPresenter: PortfolioPresentating {
    func fetchArtsResponse(_ response: Portfolio.FetchArts.Response) {
        switch response.state {
        case .loading:
            view?.fetchArtsViewModel(.init(state: .loading))
        case .loaded(let arts):
            let imageUrls = arts.map({$0.imageUrl})
            view?.fetchArtsViewModel(.init(state: .loaded(imageUrls)))
        case .error(let error):
            view?.fetchArtsViewModel(.init(state: .error(error.localizedDescription)))
        }
    }

    func selectArtResponse(_ response: Portfolio.SelectArt.Response) {}
}
