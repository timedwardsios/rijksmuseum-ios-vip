
import Service
import Utils

class PortfolioPresenter{

    let interactor: PortfolioInteracting
    weak var display: PortfolioDisplaying?

    init(interactor: PortfolioInteracting,
         display: PortfolioDisplaying? = nil) {
        self.interactor = interactor
        self.display = display
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioPresenter: PortfolioEventHandling {
    func didLoadView() {
        interactor.fetchArts()
        display?.setIsLoading(true)
    }

    func didPullToRefresh() {
        interactor.fetchArts()
        display?.setIsLoading(true)
    }

    func didTapCell(atIndex index: Int) {
        selectedArt = arts[safe: index]
    }
}

extension PortfolioPresenter: PortfolioPresentating {
    func didFetchArts(_ arts: [Art]) {
        let imageUrls = arts.map({$0.imageUrl})
        display?.setIsLoading(false)
        display?.setImageUrls(imageUrls)
    }

    func didError(_ error: Error) {
        display?.setIsLoading(false)
        display?.displayErrorMessage(error.localizedDescription)
    }
}
