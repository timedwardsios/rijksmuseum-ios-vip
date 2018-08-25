
import UIKit
import Service
import Utils

class PortfolioPresenter {
    weak var viewController: PortfolioViewControllerProtocol?
}

extension PortfolioPresenter: PortfolioPresenterProtocol{
    func didFetchArt(response: PortfolioScene.FetchArt.Response) {
        self.processFetchArtResponse(response)
    }
}

private extension PortfolioPresenter {
    func processFetchArtResponse(_ response:PortfolioScene.FetchArt.Response) {
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

    func displayFetchArt(state:PortfolioScene.FetchArt.ViewModel.State){
        let viewModel = PortfolioScene.FetchArt.ViewModel(state: state)
        self.viewController?.displayFetchArt(viewModel: viewModel)
    }

    func imageUrlsFrom(arts:[Art]) -> [URL] {
        return arts.map({$0.imageUrl})
    }
}
