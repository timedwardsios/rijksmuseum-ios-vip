import Service
import Utils

class PortfolioPresenter{
    weak var display: PortfolioDisplay?
}

extension PortfolioPresenter: PortfolioPresentation{
    func presentArts(state: State<[Art], Error>) {
        switch state {
        case .loading:
            display?.set
            display?.setViewModel(PortfolioViewModel(state: .loading))
        case .loaded(let arts):
            let imageUrls = arts.map({$0.imageUrl})
            display?.setViewModel(PortfolioViewModel(state: .loaded(imageUrls)))
        case .error(let error):
            display?.setViewModel(PortfolioViewModel(state: .error(error.localizedDescription)))
        }
    }
}
