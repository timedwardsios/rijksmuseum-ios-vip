import UIKit

import MuseumKit

class PortfolioRouter {

    private let dependencies: Dependencies
    private let dataStore: PortfolioDataStore
    weak var viewController: UIViewController?

    init(dependencies: Dependencies,
         dataStore: PortfolioDataStore) {
        self.dependencies = dependencies
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
