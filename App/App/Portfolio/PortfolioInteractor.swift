
import Service
import Utils

class PortfolioInteractor: PortfolioDataStoring{

    let presenting: PortfolioPresentating
    let artService: ArtService

    init(presenting: PortfolioPresentating,
         artService: ArtService) {
        self.presenting = presenting
        self.artService = artService
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor: PortfolioInteracting {
    func fetchArts() {
        presenting.didStartLoading()
        artService.fetchArt(completion: artServiceDidFetchArt)
    }

    func selectArt(withIndex index: Int) {
        selectedArt = arts[safe: index]
    }
}

private extension PortfolioInteractor {
    func artServiceDidFetchArt(_ result:Result<[Art], Error>){
        do {
            self.arts = try result.get()
            presenting.didFetchArts(arts)
        } catch (let error) {
            presenting.didError(error)
        }
    }
}
