
import Services
import Utils

class PortfolioInteractor: PortfolioDataStoring {

    let present: (PortfolioResponse)->Void
    let artWorker: ArtWorker

    init(present: @escaping (PortfolioResponse)->Void,
         artWorker: ArtWorker) {
        self.present = present
        self.artWorker = artWorker
    }

    var arts = [Art]()
    var selectedArt: Art?
}

extension PortfolioInteractor {

    func interact(request: PortfolioRequest) {
        switch request {
        case .fetchArts:
            present(.didBeginLoading)
            artWorker.fetchArt { [weak self] (result) in
                guard let self = self else {return}
                do {
                    self.arts = try result.get()
                    self.present(.didFetchArts(self.arts))
                } catch (let error) {
                    self.present(.didError(error))
                }
            }
        case .selectArt(let index):
            self.selectedArt = arts[safe: index]
        }
    }
}
