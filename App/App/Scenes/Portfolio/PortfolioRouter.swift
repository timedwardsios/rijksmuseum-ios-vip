
import UIKit

import Services

class PortfolioRouter{

    let dependencies: Dependencies
    let dataStore: PortfolioDataStore
    weak var viewController: UIViewController?

    init(dependencies:Dependencies,
         dataStore: PortfolioDataStore,
         viewController: PortfolioViewController? = nil){
        self.dependencies = dependencies
        self.dataStore = dataStore
        self.viewController = viewController
    }
}

extension PortfolioRouter {
    func followRoute(route: PortfolioRoute) {
        switch route {
        case .listing:
            guard let art = dataStore.selectedArt else {return}
            let listingViewController: ListingViewController = dependencies.resolve(art: art)
            viewController?.navigationController?.pushViewController(listingViewController, animated: true)
        }
    }
}
