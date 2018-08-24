
import UIKit
import Services
import Utilities

protocol ListingDataInterface{
    var art:Art?{get}
}

protocol ListingInteractorInterface:ListingDataInterface{
    //
}

protocol ListingPresenterInterface{
    //
}

protocol ListingViewControllerInterface: class{
    //
}

protocol ListingRouterInterface{
    var dataStore: ListingDataInterface { get }
}

enum Listing{
    static func buildScene()->ListingViewController{
        let presenter = ListingPresenter()
        let apiService = APIService(apiSession: URLSession.shared,
                                    apiConfig: LiveAPIConfig())
        let artDetailsService = ArtDetailsServiceAPI(apiService: apiService)
        let interactor = ListingInteractor(presenter: presenter,
                                           artDetailsService: artDetailsService)
        let router = ListingRouter(dataStore: interactor)
        let viewController = ListingViewController(interactor: interactor,
                                                   router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
