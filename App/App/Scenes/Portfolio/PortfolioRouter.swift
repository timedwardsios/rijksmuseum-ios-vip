
import UIKit

class PortfolioRouter{
    weak var viewController: PortfolioViewController?
    let dataStore: PortfolioDataInterface
    init(dataStore:PortfolioDataInterface){
        self.dataStore = dataStore
    }
}

extension PortfolioRouter: PortfolioRouterInterface{
    func navigateToListingScene() {
        let listingViewController = Listing.buildScene()
//        listingViewController.
    }
}
