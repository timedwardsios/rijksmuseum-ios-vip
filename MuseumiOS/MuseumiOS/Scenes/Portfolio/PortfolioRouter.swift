import UIKit

import MuseumKit

class PortfolioRouter {

    private let dataStore: PortfolioDataStore
    private weak var viewController: UIViewController?

    init(dataStore: PortfolioDataStore,
         viewController: UIViewController) {
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
