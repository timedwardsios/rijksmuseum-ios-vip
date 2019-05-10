import MuseumKit
import TimKit

class PortfolioInteractor: PortfolioDataStore {

    private let presenter: PortfolioPresenting
    private let artService: ArtService

    init(presenter: PortfolioPresenting,
         artService: ArtService) {
        self.presenter = presenter
        self.artService = artService
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
        artService.fetchArt { [weak self] (result) in
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
