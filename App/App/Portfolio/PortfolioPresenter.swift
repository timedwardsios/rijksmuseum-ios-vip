
import Service
import Utils

class PortfolioPresenter{
    weak var view: PortfolioViewController?
}

extension PortfolioPresenter: PortfolioPresentating{
    func didStartLoading() {
        view?.setViewModel(.init(state: .loading))
    }
    
    func didFetchArts(_ arts: [Art]) {
        let imageUrls = arts.map({$0.imageUrl})
        view?.setViewModel(.init(state: .loaded(imageUrls)))
    }
    
    func didError(_ error: Error) {
        view?.setViewModel(.init(state: .error(error.localizedDescription)))
    }
}
