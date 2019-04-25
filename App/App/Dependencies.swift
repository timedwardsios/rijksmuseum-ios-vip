
import Services

class DependenciesDefault: Dependencies {}

protocol Dependencies: Services.Dependencies {}

internal extension Dependencies {
    func resolve() -> PortfolioViewController {
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(present: presenter.present, artWorker: resolve())
        let router = PortfolioRouter(dependencies: self, dataStore: interactor)
        let viewController = PortfolioViewController(interact: interactor.interact, router: router)
        presenter.display = viewController.display
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
