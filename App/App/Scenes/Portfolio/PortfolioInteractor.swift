
import Services
import Utils

class PortfolioInteractor: PortfolioDataStore {

    private let presenter: PortfolioPresenting
    private let artWorker: ArtWorker

    init(presenter: PortfolioPresenting,
         artWorker: ArtWorker) {
        self.presenter = presenter
        self.artWorker = artWorker
    }

    private var arts = [Art]()
    private(set) var selectedArt: Art?
}

extension PortfolioInteractor: PortfolioInteracting {
    func fetchArts() {
        presenter.didBeginLoading()
        artWorker.fetchArt { [weak self] (result) in
            guard let self = self else {return}
            do {
                self.arts = try result.get()
                self.presenter.didFetchArts(self.arts)
            } catch (let error) {
                self.presenter.didError(error)
            }
        }
    }

    func selectArt(atIndex index: Int) {
        self.selectedArt = arts[safe: index]

    }
}
