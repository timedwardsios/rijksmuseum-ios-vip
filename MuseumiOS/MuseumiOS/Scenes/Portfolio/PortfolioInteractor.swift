import MuseumKit
import TimKit

class PortfolioInteractor: PortfolioDataStore {

    private let presenter: PortfolioPresenting

    init(presenter: PortfolioPresenting) {
        self.presenter = presenter
    }

    private var arts = [Art]()
    private(set) var selectedArt: Art?
}

extension PortfolioInteractor: PortfolioInteracting {

    func fetchArts() {
        presenter.didBeginLoading()
        commandArtServiceBeginFetchingArts()
    }

    func selectArt(atIndex index: Int) {
        self.selectedArt = arts[optionalAt: index]
    }
}

private extension PortfolioInteractor {

    func commandArtServiceBeginFetchingArts() {
        fetchArt { [weak self] (result) in
            self?.artServiceDidFetchArts(result: result)
        }
    }

    func artServiceDidFetchArts(result: Result<[Art], Error>) {
        switch result {
        case .success(let arts):
            self.arts = arts
            self.presenter.didFetchArts(self.arts)
        case .failure(let error):
            self.presenter.didError(error)
        }
    }
}
