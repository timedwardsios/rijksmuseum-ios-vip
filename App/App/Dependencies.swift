
import Services

class DependenciesDefault: Dependencies {}

protocol Dependencies: Services.Dependencies {}

internal extension Dependencies {
    func resolve() -> PortfolioViewController {
        let presenter = PortfolioPresenterDefault()
        let interactor = PortfolioInteractorDefault(presenter: presenter, artWorker: resolve())
        let router = PortfolioRouter(dependencies: self, dataStore: interactor)
        let viewController = PortfolioViewController(interactor: interactor, router: router)
        presenter.view = viewController
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
