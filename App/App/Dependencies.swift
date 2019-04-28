
import UIKit
import Utils
import Kit

class DependenciesDefault: Dependencies {}

protocol Dependencies: Services.Dependencies {}

extension Dependencies {

    func resolve() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    func resolve() -> PortfolioViewController {
        let viewController = PortfolioViewController.fromStoryboard(resolve())
        let presenter = PortfolioPresenter(display: viewController)
        let interactor = PortfolioInteractor(presenter: presenter, artWorker: resolve())
        let router = PortfolioRouter(dependencies: self,
                                     dataStore: interactor,
                                     viewController: viewController)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }

    func resolve(art: Art) -> ListingViewController {
        let viewController = ListingViewController.fromStoryboard(resolve())
        let presenter = ListingPresenter(display: viewController)
        let interactor = ListingInteractor(presenter: presenter, art: art)
        viewController.interactor = interactor
        return viewController
    }
}
