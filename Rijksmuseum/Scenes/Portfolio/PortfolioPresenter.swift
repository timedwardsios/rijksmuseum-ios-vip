
import UIKit

class PortfolioPresenter {
    weak var viewController: PortfolioViewControllerInput?
}

extension PortfolioPresenter: PortfolioPresenterInput{
    func presentFetchListings(response: Portfolio.FetchListings.Response) {
        DispatchQueue.main.async {
            self.processFetchListingsResponse(response)
        }
    }
}

private extension PortfolioPresenter {
    func processFetchListingsResponse(_ response:Portfolio.FetchListings.Response) {
        switch response.state {
        case .loading:
            displayFetchListings(state: .loading)
        case .loaded(let arts):
            let imageUrls = imageUrlsFrom(arts: arts)
            displayFetchListings(state: .loaded(imageUrls))
        case .error(let error):
            let errorMessage = error.localizedDescription
            displayFetchListings(state: .error(errorMessage))
        }
    }

    func displayFetchListings(state:Portfolio.FetchListings.ViewModel.State){
        let viewModel = Portfolio.FetchListings.ViewModel(state: state)
        self.viewController?.displayFetchListings(viewModel: viewModel)
    }

    func imageUrlsFrom(arts:[Art]) -> [URL] {
        return arts.map({$0.imageUrl})
    }
}
