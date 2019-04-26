
import Services

class DependenciesDefault: Dependencies {}

protocol Dependencies: Services.Dependencies {}

internal extension Dependencies {
    func resolve() -> PortfolioViewController {
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(presentResponse: presenter.presentResponse,
                                             artWorker: resolve())
        let router = PortfolioRouter(dependencies: self,
                                     dataStore: interactor)
        let viewController = PortfolioViewController(processRequest: interactor.processRequest,
                                                     followRoute: router.followRoute)
        presenter.displayViewModel = viewController.displayViewModel
        router.viewController = viewController
        return viewController
    }

    func resolve(art: Art) -> ListingViewController {
        let presenter = ListingPresenter()
        let interactor = ListingInteractor(presentResponse: presenter.presentResponse,
                                           art: art)
        let viewController = ListingViewController(processRequest: interactor.processRequest)
        presenter.displayViewModel = viewController.displayViewModel
        return viewController
    }
}
