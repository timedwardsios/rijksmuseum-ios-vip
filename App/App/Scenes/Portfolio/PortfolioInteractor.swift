
import UIKit
import Workers
import Utility

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
    func performFetchArt(request: Portfolio.FetchArt.Request) {
        presentFetchArt(state: .loading)
        artWorker.fetchArt {[weak self] (result) in
            self?.processFetchArtResult(result)
        }
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
        presenter.presentFetchArt(response: response)
    }
}
