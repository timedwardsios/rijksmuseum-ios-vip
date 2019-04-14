import Service
import Utils

class PortfolioInteractor: PortfolioDataStoring{

    let presenter: PortfolioPresenting
    let artService: ArtService

    init(presenter: PortfolioPresenting,
         artService: ArtService) {
        self.presenter = presenter
        self.artService = artService
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor: PortfolioInteracting {
    func selectArt(withIndex index: Int) {
        selectedArt = arts[safe: index]
    }

    internal func fetchArt() {
        presenter.didBeginLoading()
        artService.fetchArt(completion: processFetchArtResult)
    }
}

private extension PortfolioInteractor {
    func processFetchArtResult(_ result:Result<[Art], Error>){
        switch result {
        case .success(let arts):
            self.arts = arts
            presenter.didFetchArts(arts)
        case .failure(let error):
            presenter.didError(error)
        }
    }
}
