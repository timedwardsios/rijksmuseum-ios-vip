
import UIKit

class PortfolioInteractor: PortfolioDataStore{
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

extension PortfolioInteractor: PortfolioInteractorInterface {
    // MARK: FetchListings
    func performFetchListings(request: Portfolio.FetchListings.Request) {
        presentFetchListings(state: .loading)
        artPrimitiveWorker.fetchPrimitives {[weak self] (result) in
            self?.processFetchListingsResult(result)
        }
    }

    func processFetchListingsResult(_ result:ArtPrimitiveResult){
        switch result {
        case .success(let artPrimtives):
            self.artPrimitives = artPrimtives
            presentFetchListings(state: .loaded(artPrimtives))
        case .failure(let error):
            presentFetchListings(state: .error(error))
        }
    }

    func presentFetchListings(state:Portfolio.FetchListings.Response.State){
        let response = Portfolio.FetchListings.Response(state: state)
        presenter.presentFetchListings(response: response)
    }

    //    func setHighlightedIndex(_ index: Int?) {
    ////        presenter.presentHighlightedIndex(index)
    //    }
    //
    //    func setSelectedIndex(_ index: Int) {
    //        if artPrimitives.indices.contains(index) {
    //            selectedArtPrimitive = artPrimitives[index]
    //        }
    //    }
}
