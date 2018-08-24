
import UIKit
import Services
import Utilities

protocol ViewListingInteractorInterface{
    //
}

protocol ViewListingPresenterInterface{
    //
}

protocol ViewListingViewControllerInterface: class{
    //
}

protocol ViewListingDataStore{
    //
}

protocol ViewListingRouterInterface{
    var dataStore: ViewListingDataStore? { get }
}

enum ViewListingScene{
    static func build()->ViewListingViewController{
        let presenter = ViewListingPresenter()
        let apiService = APIService(apiSession: URLSession.shared,
                                    apiConfig: LiveAPIConfig())
        let artDetailsService = ArtDetailsServiceAPI(apiService: apiService)
        let router = ViewListingRouter()
        let interactor = ViewListingInteractor(presenter: presenter,
                                               artDetailsService: artDetailsService)
        let viewController = ViewListingViewController(interactor: interactor,
                                                     router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
