
import UIKit
import Service
import Utils

class PortfolioPresenter{
    weak var viewController: PortfolioViewController?
}

extension PortfolioPresenter: PortfolioPresenterProtocol{
    func presentFetchArt(response: Portfolio.FetchArt.Response) {
        self.processFetchArtResponse(response)
    }
}

private extension PortfolioPresenter {
    func processFetchArtResponse(_ response:Portfolio.FetchArt.Response) {
        switch response.state {
        case .loading:
            displayFetchArt(state: .loading)
        case .loaded(let arts):
            let imageUrls = imageUrlsFrom(arts: arts)
            displayFetchArt(state: .loaded(imageUrls))
        case .error(let error):
            let errorMessage = error.message
            displayFetchArt(state: .error(errorMessage))
        }
    }

    func displayFetchArt(state:Portfolio.FetchArt.ViewModel.State){
        let viewModel = Portfolio.FetchArt.ViewModel(state: state)
        self.viewController?.displayFetchArt(viewModel: viewModel)
    }

    func imageUrlsFrom(arts:[Art]) -> [URL] {
        return arts.map({$0.imageUrl})
    }
}
