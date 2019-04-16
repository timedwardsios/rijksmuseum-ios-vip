
import Service
import Utils

class PortfolioInteractor: PortfolioDataStore {

    let presenter: PortfolioPresentating
    let artService: ArtService

    init(presenter: PortfolioPresentating,
         artService: ArtService) {
        self.presenter = presenter
        self.artService = artService
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor: PortfolioInteracting {
    func fetchArtsRequest(_ request: Portfolio.FetchArts.Request) {
        presenter.fetchArtsResponse(.init(state: .loading))
        artService.fetchArt { [weak self] (result) in
            guard let self = self else {return}
            do {
                let urls = try result.get()
                self.presenter.fetchArtsResponse(.init(state: .loaded(urls)))
            } catch (let error) {
                self.presenter.fetchArtsResponse(.init(state: .error(error)))
            }
        }
    }

    func selectArtRequest(_ request: Portfolio.SelectArt.Request) {
        self.selectedArt = arts[safe: request.index]
    }
}
