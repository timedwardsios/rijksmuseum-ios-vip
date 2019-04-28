
import UIKit

import Kit

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
        guard let art = dataStore.selectedArt else {
            return
        }
        let listingViewController: ListingViewController = dependencies.resolve(art: art)
        viewController?.navigationController?.pushViewController(listingViewController, animated: true)
    }
}
