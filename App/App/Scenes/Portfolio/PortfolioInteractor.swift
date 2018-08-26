
import UIKit
import Service
import Utils

class PortfolioInteractor:PortfolioDataStore{
    let presenter:PortfolioPresenter
    let dependencies: Portfolio.Dependencies
    init(presenter: PortfolioPresenter,
                  dependencies: Portfolio.Dependencies) {
        self.presenter = presenter
        self.dependencies = dependencies
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor: PortfolioInteractorProtocol {
    func fetchArt(request: Portfolio.FetchArt.Request) {
        presentFetchArt(state: .loading)
        dependencies.artService.fetchArt {[weak self] (result) in
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
        presenter.presentFetchArt(response: response)
    }
}
