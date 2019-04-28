
import Kit
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
        commandArtWorkerBeginFetchingArts()
    }

    func selectArt(atIndex index: Int) {
        self.selectedArt = arts[optionalAt: index]
    }
}

private extension PortfolioInteractor {

    func commandArtWorkerBeginFetchingArts(){
        artWorker.fetchArt { [weak self] (result) in
            self?.artWorkerDidFetchArts(result: result)
        }
    }

    func artWorkerDidFetchArts(result: Result<[Art], Error>){
        switch result {
        case .success(let arts):
            self.arts = arts
            self.presenter.didFetchArts(self.arts)
        case .failure(let error):
            self.presenter.didError(error)
        }
    }
}
