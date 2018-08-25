
import UIKit
import Services

class PortfolioRouter{
    weak var viewController: PortfolioViewController?
    let dataStore:PortfolioDataStore
    init(dataStore:PortfolioDataStore){
        self.dataStore = dataStore
    }
}

extension PortfolioRouter: PortfolioRouterInterface{
    func navigateToListingScene() {
        guard let art = dataStore.selectedArt else {return}
        let listingViewController = ListingScene.build(dependencies: AppDependencies(),
                                                       art: art)
        viewController?.navigationController?.pushViewController(listingViewController,
                                                                       animated: true)
    }
}
