
import UIKit

// MARK: init
class PortfolioInteractor: PortfolioInteractorInterface, PortfolioDataStore{
    let presenter: PortfolioPresenterInterface
    let artPrimitiveWorker: ArtPrimitiveWorker
    init(presenter:PortfolioPresenterInterface,
         artPrimitiveWorker:ArtPrimitiveWorker) {
        self.presenter = presenter
        self.artPrimitiveWorker = artPrimitiveWorker
    }

    var artPrimitives = [ArtPrimitive]()
    var selectedArtPrimitive: ArtPrimitive?
}

// MARK: FetchListings
extension PortfolioInteractor {
    func performFetchListings(request: Portfolio.FetchListings.Request) {
        presentFetchListings(state: .loading)
        artPrimitiveWorker.fetchPrimitives {[weak self] (result) in
            self?.processFetchListingsResult(result)
        }
    }

    private func processFetchListingsResult(_ result:ArtPrimitiveResult){
        switch result {
        case .success(let artPrimtives):
            self.artPrimitives = artPrimtives
            presentFetchListings(state: .loaded(artPrimtives))
        case .failure(let error):
            presentFetchListings(state: .error(error))
        }
    }

    private func presentFetchListings(state:Portfolio.FetchListings.Response.State){
        let response = Portfolio.FetchListings.Response(state: state)
        presenter.presentFetchListings(response: response)
    }
}
