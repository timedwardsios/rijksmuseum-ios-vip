
import Service

typealias Dependencies = ServiceDependencies & AppDependencies

class DependenciesDefault: Dependencies {}

protocol AppDependencies {
    func resolve() -> PortfolioViewController
    func resolve(art: Art) -> ListingViewController
}

extension AppDependencies where Self: Dependencies {
    func resolve() -> PortfolioViewController {
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(presenter: presenter, artService: resolve())
        let router = PortfolioRouter(dependencies: self, dataStore: interactor)
        let viewController = PortfolioViewController(interactor: interactor, router: router)
        presenter.view = viewController
        router.viewController = viewController
        return viewController
    }

    func resolve(art: Art) -> ListingViewController {
        let presenter = ListingPresenter()
        let interactor = ListingInteractor(presenter: presenter, artDetailsService: resolve(), art: art)
        let router = ListingRouter(dependencies: self, dataStore: interactor)
        let viewController = ListingViewController(interactor: interactor, router: router)
        presenter.view = viewController
        router.viewController = viewController
        return viewController
    }
}
