
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
            viewModel = Portfolio.FetchListings.ViewModel(viewState: .loaded(true),
                                                          highlightedIndex: nil)
        case .failure(let error):
            viewModel = Portfolio.FetchListings.ViewModel(viewState: .error(error.localizedDescription),
                                                          highlightedIndex: nil)
        }
        viewController?.viewModel = viewModel
    }

    func presentHighlightedIndex(_ index: Int?) {
        let viewModel = Portfolio.FetchListings.ViewModel(viewState: .loaded(false),
                                                      highlightedIndex: index)
        viewController?.viewModel = viewModel
    }
}
