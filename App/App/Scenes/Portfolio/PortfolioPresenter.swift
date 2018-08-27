
import UIKit
import Service
import Utils

class PortfolioPresenter{
    weak var output: PortfolioPresenterOutput?
}

extension PortfolioPresenter: PortfolioPresenterInput{
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
            let errorMessage = error.message
            presentFetchArt(state: .error(errorMessage))
        }
    }

    func presentFetchArt(state:Portfolio.FetchArt.ViewModel.State){
        let viewModel = Portfolio.FetchArt.ViewModel(state: state)
        output?.presentFetchArt(viewModel: viewModel)
    }

    func imageUrlsFrom(arts:[Art]) -> [URL] {
        return arts.map({$0.imageUrl})
    }
}
