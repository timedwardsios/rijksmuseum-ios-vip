
import UIKit
import Service
import Utils

class PortfolioInteractor:Portfolio.DataStore{
    let output:Portfolio.Interactor.Output
    let dependencies: Portfolio.Dependencies
    init(output: Portfolio.Interactor.Output,
         dependencies: Portfolio.Dependencies) {
        self.output = output
        self.dependencies = dependencies
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor: Portfolio.Interactor.Input {
    func performFetchArt(request: Portfolio.FetchArt.Request) {
        presentFetchArt(state: .loading)
        dependencies.artService.fetchArt {[weak self] (result) in
            self?.processFetchArtResult(result)
        }
    }

    func performSelectArt(request: Portfolio.SelectArt.Request) {
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
        output.presentFetchArt(response: response)
    }
}
