
import Services
import Utils

class PortfolioInteractor: PortfolioDataStoring {

    let presentResponse: (PortfolioResponse)->Void
    let artWorker: ArtWorker

    init(presentResponse: @escaping (PortfolioResponse)->Void,
         artWorker: ArtWorker) {
        self.presentResponse = presentResponse
        self.artWorker = artWorker
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor {

    func processRequest(request: PortfolioRequest) {
        switch request {
        case .fetchArts:
            presentResponse(.didBeginLoading)
            artWorker.fetchArt { [weak self] (result) in
                guard let self = self else {return}
                do {
                    self.arts = try result.get()
                    self.presentResponse(.didFetchArts(self.arts))
                } catch (let error) {
                    self.presentResponse(.didError(error))
                }
            }
        case .selectArt(let index):
            self.selectedArt = arts[safe: index]
        }
    }
}
