
import Services

class DependenciesDefault: Dependencies {}

protocol Dependencies: Services.Dependencies {}

internal extension Dependencies {
    func resolve() -> PortfolioViewController {
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(presentResponse: presenter.presentResponse,
                                             artWorker: resolve())
        let router = PortfolioRouter(dependencies: self, dataStore: interactor)
        let viewController = PortfolioViewController(processRequest: interactor.processRequest,
                                                     router: router)
        presenter.displayViewModel = viewController.displayViewModel
        router.viewController = viewController
        return viewController
    }

    func resolve(art: Art) -> ListingViewController {
        let presenter = ListingPresenter()
        let interactor = ListingInteractor(presenter: presenter, art: art)
        let router = ListingRouter(dependencies: self, dataStore: interactor)
        let viewController = ListingViewController(interactor: interactor, router: router)
        presenter.view = viewController
        router.viewController = viewController
        return viewController
    }
}
