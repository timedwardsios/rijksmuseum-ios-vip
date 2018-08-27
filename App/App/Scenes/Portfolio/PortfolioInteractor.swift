
import UIKit
import Service
import Utils

class PortfolioInteractor{
    let output:PortfolioInteractorOutput
    let artService:ArtService
    init(output: PortfolioInteractorOutput,
         artService: ArtService) {
        self.output = output
        self.artService = artService
    }

    var arts = [Art]()
}

extension PortfolioInteractor: PortfolioInteractorInput {
    func executeFetchArt(request: PortfolioScene.FetchArt.Request) {
        presentFetchArt(state: .loading)
        artService.fetchArt {[weak self] (result) in
            self?.processFetchArtResult(result)
        }
    }

    func executeSelectArt(request: PortfolioScene.SelectArt.Request) {
        guard arts.indices.contains(request.index) else {return}
        let selectedArt = arts[request.index]
        output.presentSelectArt(response: PortfolioScene.SelectArt.Response(art:selectedArt))
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

    func presentFetchArt(state:PortfolioScene.FetchArt.Response.State){
        let response = PortfolioScene.FetchArt.Response(state: state)
        output.presentFetchArt(response: response)
    }
}
