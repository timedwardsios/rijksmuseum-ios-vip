
import UIKit
import Services
import Utilities

protocol ListingInteractorInterface{
    //
}

protocol ListingPresenterInterface{
    //
}

protocol ListingViewControllerInterface: class{
    //
}

protocol ListingDataStore{
    //
}

protocol ListingRouterInterface{
    var dataStore: ListingDataStore? { get }
}

enum ListingScene{
    static func build()->ListingViewController{
        let presenter = ListingPresenter()
        let apiService = APIService(apiSession: URLSession.shared,
                                    apiConfig: LiveAPIConfig())
        let artDetailsService = ArtDetailsServiceAPI(apiService: apiService)
        let router = ListingRouter()
        let interactor = ListingInteractor(presenter: presenter,
                                               artDetailsService: artDetailsService)
        let viewController = ListingViewController(interactor: interactor,
                                                     router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
