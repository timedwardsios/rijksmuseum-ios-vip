
import UIKit
import Services
import Utilities

class PortfolioInteractor:PortfolioDataStore{
    let presenter: PortfolioPresenterInterface
    let artService: ArtServiceInterface
    init(presenter:PortfolioPresenterInterface,
         artService:ArtServiceInterface) {
        self.presenter = presenter
        self.artService = artService
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor: PortfolioInteractorInterface {
    func fetchArt(request: Portfolio.FetchArt.Request) {
        presentFetchArt(state: .loading)
        artService.fetchArt {[weak self] (result) in
            self?.processFetchArtResult(result)
        }
    }

    func selectArt(request: Portfolio.SelectArt.Request) {
        guard arts.indices.contains(request.index) else {
            return
        }
        selectedArt = arts[request.index]
    }
}

private extension PortfolioInteractor {
    func processFetchArtResult(_ result:Result<[Art]>){
        switch result {
        case .success(let arts):
            self.arts = arts
            presentFetchArt(state: .loaded(arts))
        case .failure(let error):
            presentFetchArt(state: .error(error))
        }
    }

    func presentFetchArt(state:Portfolio.FetchArt.Response.State){
        let response = Portfolio.FetchArt.Response(state: state)
        presenter.didFetchArt(response: response)
    }
}
