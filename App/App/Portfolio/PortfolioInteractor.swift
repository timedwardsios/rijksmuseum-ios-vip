
import Service
import Utils

class PortfolioInteractor {

    weak var presenter: PortfolioPresentating?
    
    let artService: ArtService

    init(presenter: PortfolioPresentating? = nil,
         artService: ArtService) {
        self.presenter = presenter
        self.artService = artService
    }
}

extension PortfolioInteractor: PortfolioInteracting {
    func fetchArts() {
        artService.fetchArt(completion: artServiceDidFetchArt)
    }
}

private extension PortfolioInteractor {
    func artServiceDidFetchArt(_ result:Result<[Art], Error>){
        do {
            presenter?.didFetchArts(try result.get())
        } catch (let error) {
            presenter?.didError(error)
        }
    }
}
