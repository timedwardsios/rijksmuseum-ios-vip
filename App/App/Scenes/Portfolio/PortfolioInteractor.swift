
import Services
import Utils

class PortfolioInteractor: PortfolioDataStore {

    let presenter: PortfolioPresenting
    let artWorker: ArtWorker

    init(presenter: PortfolioPresenting,
         artWorker: ArtWorker) {
        self.presenter = presenter
        self.artWorker = artWorker
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor: PortfolioInteracting {
    
    func processRequest(_ request: PortfolioRequest) {
        switch request {
        case .fetchArts:
            presenter.presentResponse(.didBeginLoading)
            artWorker.fetchArt { [weak self] (result) in
                guard let self = self else {return}
                do {
                    self.arts = try result.get()
                    self.presenter.presentResponse(.didFetchArts(self.arts))
                } catch (let error) {
                    self.presenter.presentResponse(.didError(error))
                }
            }
        case .selectArt(let index):
            self.selectedArt = arts[safe: index]
        }
    }
}
