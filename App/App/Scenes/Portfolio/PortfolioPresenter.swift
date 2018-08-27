
import UIKit
import Service
import Utils

class PortfolioPresenter{
    weak var output: PortfolioPresenterOutput?
    weak var router: PortfolioRouter?
}

extension PortfolioPresenter: PortfolioPresenterInput{
    func presentFetchArt(response: PortfolioScene.FetchArt.Response) {
        processFetchArtResponse(response)
    }
    
    func presentSelectArt(response: PortfolioScene.SelectArt.Response) {
        router?.didSelectArt(response.art)
    }
}

private extension PortfolioPresenter {
    func processFetchArtResponse(_ response:PortfolioScene.FetchArt.Response) {
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

    func presentFetchArt(state:PortfolioScene.FetchArt.ViewModel.State){
        let viewModel = PortfolioScene.FetchArt.ViewModel(state: state)
        output?.displayFetchArt(viewModel: viewModel)
    }

    func imageUrlsFrom(arts:[Art]) -> [URL] {
        return arts.map({$0.imageUrl})
    }
}
