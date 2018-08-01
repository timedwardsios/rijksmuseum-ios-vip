
import UIKit

protocol PortfolioInteractorInterface{
    func fetchListings(request: Portfolio.FetchListings.Request)
    func numberOfListings()->Int
    func imageUrlForListingAtIndex(_ index:Int)->URL?
    func setHighlightedIndex(_ index:Int?)
    func setSelectedIndex(_ index:Int)
}

protocol PortfolioDataStore{
    var selectedArtPrimitive:ArtPrimitive? { get }
}

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
    func fetchListings(request: Portfolio.FetchListings.Request) {
        artPrimitiveWorker.fetchPrimitives {[weak self] (result) in
            if case let .success(artPrimitives) = result {
                self?.artPrimitives = artPrimitives
            }
            let response = Portfolio.FetchListings.Response(result: result)
            self?.presenter.presentListings(response: response)
        }
    }

    func numberOfListings() -> Int {
        return artPrimitives.count
    }

    func imageUrlForListingAtIndex(_ index: Int) -> URL? {
        if artPrimitives.indices.contains(index) {
            return artPrimitives[index].imageUrl
        }
        return nil
    }

    func setHighlightedIndex(_ index: Int?) {
        presenter.presentHighlightedIndex(index)
    }

    func setSelectedIndex(_ index: Int) {
        if artPrimitives.indices.contains(index) {
            selectedArtPrimitive = artPrimitives[index]
        }
    }
}
