import MuseumKit
import TimKit

class PortfolioInteractor {

    private let presenter: PortfolioPresenting
    private let artController: ArtController
    private let router: PortfolioRouter
    private let model: Model

    init(presenter: PortfolioPresenting,
         artController: ArtController,
         router: PortfolioRouter,
         model: Model) {
        self.presenter = presenter
        self.artController = artController
        self.router = router
        self.model = model
    }

    private var arts = [Art]()
}

extension PortfolioInteractor: PortfolioInteracting {

    func fetchArts() {
        presenter.presentLoading()
        artController.fetchArt() {
            switch $0 {
            case let .success(arts):
                self.arts = arts
                self.presenter.presentArts(arts)
            case let .failure(error):
                print(error)
            }
        }
    }

    func selectArt(atIndex index: Int) {
        if let art = arts[optionalAt: index] {
            router.displayDetailsForArt(art)
        }
    }
}
