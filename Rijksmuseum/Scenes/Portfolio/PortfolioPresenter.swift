
import UIKit

class PortfolioPresenter {
    weak var viewController: PortfolioViewControllerInput?
}

extension PortfolioPresenter: PortfolioPresenterInput{
    func presentFetchArt(response: Portfolio.FetchArt.Response) {
        //        DispatchQueue.main.async {
        //            self.processFetchArtResponse(response)
        switch response.state {
        case .loading:
            let viewModel = Portfolio.FetchArt.ViewModel(state: .loading)
            self.viewController?.displayFetchArt(viewModel: viewModel)
        case .loaded(let arts):
            let imageUrls = arts.map({$0.imageUrl})
            let viewModel = Portfolio.FetchArt.ViewModel(state: .loaded(imageUrls))
            self.viewController?.displayFetchArt(viewModel: viewModel)
        case .error(let error):
            fatalError()
//            let errorMessage = error.localizedDescription
//            let viewModel = Portfolio.FetchArt.ViewModel(state: .error(errorMessage))
//            self.viewController?.displayFetchArt(viewModel: viewModel)
        }
        //        }
    }
}

private extension PortfolioPresenter {
    //    func processFetchArtResponse(_ response:Portfolio.FetchArt.Response) {
    //        switch response.state {
    //        case .loading:
    //            displayFetchArt(state: .loading)
    //        case .loaded(let arts):
    //            let imageUrls = imageUrlsFrom(arts: arts)
    //            displayFetchArt(state: .loaded(imageUrls))
    //        case .error(let error):
    //            let errorMessage = error.localizedDescription
    //            displayFetchArt(state: .error(errorMessage))
    //        }
    //    }
    //
    //    func displayFetchArt(state:Portfolio.FetchArt.ViewModel.State){
    //        let viewModel = Portfolio.FetchArt.ViewModel(state: state)
    //        self.viewController?.displayFetchArt(viewModel: viewModel)
    //    }
    //
    //    func imageUrlsFrom(arts:[Art]) -> [URL] {
    //        return arts.map({$0.imageUrl})
    //    }
}
