import UIKit
import MuseumKit

let dependencies: Dependencies = DependenciesDefault()

protocol Dependencies {
    func resolve() -> PortfolioViewController
    func resolve(art: Art) -> ListingViewController
}

private class DependenciesDefault: Dependencies {

    func resolve() -> PortfolioViewController {
        let viewController = PortfolioViewController.from(storyboard: resolve())
        let presenter = PortfolioPresenter(display: viewController)
        let interactor = PortfolioInteractor(presenter: presenter, artService: MuseumKit.dependencies.resolve())
        let router = PortfolioRouter(dataStore: interactor,
                                     viewController: viewController)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }

    func resolve(art: Art) -> ListingViewController {
        let viewController = ListingViewController.from(storyboard: resolve())
        let presenter = ListingPresenter(display: viewController)
        let interactor = ListingInteractor(presenter: presenter, art: art)
        viewController.interactor = interactor
        return viewController
    }

    func resolve() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
