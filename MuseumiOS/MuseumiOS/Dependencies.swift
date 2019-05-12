import UIKit
import MuseumKit

class Dependencies {

    private let museumKitDependencies = MuseumKit.Dependencies()

    var portfolioViewController: PortfolioViewController {
        let viewController = PortfolioViewController.from(storyboard: storyboard)
        let presenter = PortfolioPresenter(display: viewController)
        let interactor = PortfolioInteractor(presenter: presenter, artService: museumKitDependencies.artService)
        let router = PortfolioRouter(dependencies: self,
                                     dataStore: interactor,
                                     viewController: viewController)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }

    func listingViewController(art: Art) -> ListingViewController {
        let viewController = ListingViewController.from(storyboard: storyboard)
        let presenter = ListingPresenter(display: viewController)
        let interactor = ListingInteractor(presenter: presenter, art: art)
        viewController.interactor = interactor
        return viewController
    }

    private lazy var storyboard: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
}
