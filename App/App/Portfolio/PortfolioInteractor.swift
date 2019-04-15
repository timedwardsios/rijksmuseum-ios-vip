import Service
import Utils

class PortfolioInteractor: PortfolioDataStoring{

    let presentation: PortfolioPresentation
    let artService: ArtService

    init(presentation: PortfolioPresentation,
         artService: ArtService) {
        self.presentation = presentation
        self.artService = artService
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor: PortfolioInteraction {
    func fetchArts() {
        presentation.presentArts(state: .loading)
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
        } catch (let error) {
            presentation.presentArts(state: .error(error))
        }
    }
}
