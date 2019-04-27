
import UIKit
import Utils
import Services

class DependenciesDefault: Dependencies {}

protocol Dependencies: Services.Dependencies {}

extension Dependencies {
    
    func resolve() -> PortfolioViewController {
        let viewController = UIStoryboard.main.instantiateViewController(forType: PortfolioViewController.self)!
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
        let viewController = UIStoryboard.main.instantiateViewController(forType: ListingViewController.self)!
        let presenter = ListingPresenter(display: viewController)
        let interactor = ListingInteractor(presenter: presenter, art: art)
        viewController.interactor = interactor
        return viewController
    }
}
