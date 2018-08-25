
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
        struct Dependencies:ListingDependencies {
            let artDetailsService: ArtDetailsServiceInterface
            let art: Art
        }
        guard let art = dataStore.selectedArt else {return}
        let apiSession = URLSession.shared
        let apiConfig = LiveAPIConfig()
        let apiService = APIService(apiSession: apiSession,
                                    apiConfig: apiConfig)
        let artDetailsService = ArtDetailsServiceAPI(apiService: apiService)
        let dependencies = Dependencies(artDetailsService: artDetailsService,
                                        art: art)
        let listingViewController = Listing.build(dependencies: dependencies)
        viewController?.navigationController?.pushViewController(listingViewController,
                                                                       animated: true)
    }
}
