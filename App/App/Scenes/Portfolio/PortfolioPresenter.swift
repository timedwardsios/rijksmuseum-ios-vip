
import Services
import Utils

class PortfolioPresenter{
    weak var display: PortfolioDisplaying?

    init(display: PortfolioDisplaying? = nil){
        self.display = display
    }
}

extension PortfolioPresenter: PortfolioPresenting {

    func didBeginLoading() {
        display?.displayIsLoading(true)
    }

    func didFetchArts(_ arts: [Art]) {
        display?.displayIsLoading(false)
        let imageUrls = arts.map({$0.imageUrl})
        display?.displayImageUrls(imageUrls)
    }

    func didError(_ error: Error) {
        display?.displayIsLoading(false)
        display?.displayErrorMessage(error.localizedDescription)
    }
}
