
import UIKit

import Services

class PortfolioRouter{

    private let dependencies: Dependencies
    private let dataStore: PortfolioDataStore
    private weak var viewController: UIViewController?

    init(dependencies: Dependencies,
         dataStore: PortfolioDataStore,
         viewController: UIViewController){
        self.dependencies = dependencies
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension PortfolioRouter: PortfolioRouting {
    func routeToListing() {
        if let art = dataStore.selectedArt {
            let listingViewController: ListingViewController = dependencies.resolve(art: art)
            viewController?.navigationController?.pushViewController(listingViewController, animated: true)
        }
    }
}
