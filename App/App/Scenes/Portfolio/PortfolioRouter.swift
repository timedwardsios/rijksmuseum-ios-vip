
import UIKit
import Service

class PortfolioRouter{
    weak var viewController: PortfolioViewController?
    let dataStore:PortfolioDataStore
    init(dataStore:PortfolioDataStore){
        self.dataStore = dataStore
    }
}

extension PortfolioRouter: PortfolioRouting {
    func navigateToListing() {
        guard let art = dataStore.selectedArt else {return}
        let listingViewController = Listing.build(dependencies: DependenciesDefault(),
                                                       art: art)
        viewController?.navigationController?.pushViewController(listingViewController,
                                                                       animated: true)
    }
}
