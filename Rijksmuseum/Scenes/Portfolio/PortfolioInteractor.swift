
import UIKit

class PortfolioInteractor: PortfolioDataStore{
    let presenter: PortfolioPresenterInput
    let artWorker: ArtWorkerInput
    init(presenter:PortfolioPresenterInput,
         artWorker:ArtWorkerInput) {
        self.presenter = presenter
        self.artWorker = artWorker
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor: PortfolioInteractorInput {
    func performFetchListings(request: Portfolio.FetchListings.Request) {
        presentFetchListings(state: .loading)
        artWorker.fetchArt {[weak self] (result) in
            self?.processFetchListingsResult(result)
        }
    }
}

private extension PortfolioInteractor {
    func processFetchListingsResult(_ result:ArtWorkerResult){
        switch result {
        case .success(let arts):
            self.arts = arts
            presentFetchListings(state: .loaded(arts))
        case .failure(let error):
            presentFetchListings(state: .error(error))
        }
    }

    func presentFetchListings(state:Portfolio.FetchListings.Response.State){
        let response = Portfolio.FetchListings.Response(state: state)
        presenter.presentFetchListings(response: response)
    }
}
