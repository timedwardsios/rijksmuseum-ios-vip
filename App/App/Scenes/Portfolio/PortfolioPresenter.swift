
import UIKit
import Service
import Utils

class PortfolioPresenter{

    weak var view: PortfolioView?
}

extension PortfolioPresenter: PortfolioPresenting{
    func presentFetchArt(response: Portfolio.FetchArt.Response) {
        self.processFetchArtResponse(response)
    }
}

private extension PortfolioPresenter {
    func processFetchArtResponse(_ response:Portfolio.FetchArt.Response) {
        switch response.state {
        case .loading:
            presentFetchArt(state: .loading)
        case .loaded(let arts):
            let imageUrls = imageUrlsFrom(arts: arts)
            presentFetchArt(state: .loaded(imageUrls))
        case .error(let error):
            let errorMessage = error.localizedDescription
            presentFetchArt(state: .error(errorMessage))
        }
    }

    func presentFetchArt(state:Portfolio.ViewModel.State){
        let viewModel = Portfolio.ViewModel(state: state)
        view?.setViewModel(viewModel)
    }

    func imageUrlsFrom(arts:[Art]) -> [URL] {
        return arts.map({$0.imageUrl})
    }
}
