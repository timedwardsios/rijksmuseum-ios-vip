
import UIKit

protocol PortfolioPresenterInterface{
    func presentListings(response: Portfolio.FetchListings.Response)
    func presentHighlightedIndex(_ index:Int?)
}

class PortfolioPresenter: PortfolioPresenterInterface{
    weak var viewController: PortfolioViewControllerInterface?

    func presentListings(response: Portfolio.FetchListings.Response) {
        let viewModel:Portfolio.FetchListings.ViewModel
        switch response.result {
        case .success(_):
            viewModel = Portfolio.FetchListings.ViewModel(viewState: .refreshed,
                                                          hightlightedIndex: nil)
        case .failure(let error):
            viewModel = Portfolio.FetchListings.ViewModel(viewState: .error(error.localizedDescription),
                                                          hightlightedIndex: nil)
        }
        viewController?.viewModel = viewModel
    }

    func presentHighlightedIndex(_ index: Int?) {
        let viewModel = Portfolio.FetchListings.ViewModel(viewState: .loaded,
                                                      hightlightedIndex: index)
        viewController?.viewModel = viewModel
    }
}
