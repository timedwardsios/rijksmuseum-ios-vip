import Service
import Utils

class PortfolioPresenter{
    weak var view: PortfolioViewing?
}

extension PortfolioPresenter: PortfolioPresenting{
    func didBeginLoading() {
        view?.setViewModel(PortfolioViewModel(state: .loading))
    }

    func didFetchArts(_ arts: [Art]) {
        let imageUrls = arts.map({$0.imageUrl})
        view?.setViewModel(PortfolioViewModel(state: .loaded(imageUrls)))
    }

    func didError(_ error: Error) {
        view?.setViewModel(PortfolioViewModel(state: .error(error.localizedDescription)))
    }
}
