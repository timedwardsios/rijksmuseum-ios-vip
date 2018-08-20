
import UIKit

class PortfolioPresenter{
    weak var viewController: PortfolioViewControllerInterface?
}
extension PortfolioPresenter: PortfolioPresenterInterface{
    func presentFetchListings(response: Portfolio.FetchListings.Response) {
        DispatchQueue.main.async {
            self.processFetchListingsResponse(response)
        }
    }

    func processFetchListingsResponse(_ response:Portfolio.FetchListings.Response) {
        switch response.state {
        case .loading:
            displayFetchListings(state: .loading)
        case .loaded(let artPrimitives):
            let imageUrls = imageUrlsFrom(artPrimitives: artPrimitives)
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

    func imageUrlsFrom(artPrimitives:[ArtPrimitive]) -> [URL] {
        return artPrimitives.map({$0.imageUrl})
    }
}
