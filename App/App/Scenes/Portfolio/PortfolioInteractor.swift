
import Services
import Utils

class PortfolioInteractor: PortfolioDataStoring {

    let presenter: PortfolioPresentating
    let artWorker: ArtWorker

    init(presenter: PortfolioPresentating,
         artWorker: ArtWorker) {
        self.presenter = presenter
        self.artWorker = artWorker
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor: PortfolioInteracting {
    func processFetchArtsRequest(_ request: Portfolio.FetchArts.Request) {
        presenter.presentFetchArtsResponse(.init(state: .loading))
        artWorker.fetchArt { [weak self] (result) in
            guard let self = self else {return}
            do {
                self.arts = try result.get()
                self.presenter.presentFetchArtsResponse(.init(state: .loaded(self.arts)))
            } catch (let error) {
                self.presenter.presentFetchArtsResponse(.init(state: .error(error)))
            }
        }
    }

    func processSelectArtRequest(_ request: Portfolio.SelectArt.Request) {
        self.selectedArt = arts[safe: request.index]
    }
}
