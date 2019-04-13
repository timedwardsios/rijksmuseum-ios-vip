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

extension PortfolioInteractor: PortfolioEventHandling {
    func didLoadView() {
        fetchArt()
    }

    func didPullToRefresh() {
        fetchArt()
    }
}

private extension PortfolioInteractor {
    func fetchArt() {
        presenter.didBeginLoading()
        artService.fetchArt {[weak self] (result) in
            self?.processFetchArtResult(result)
        }
    }

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
