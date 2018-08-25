
import UIKit
import Services
import Utilities

protocol ListingDependencies{
    var artDetailsService:ArtDetailsServiceInterface{get}
    var art:Art{get}
}

protocol ListingDataStore{}

protocol ListingInteractorInterface{}

protocol ListingPresenterInterface{}

protocol ListingViewControllerInterface: class{}

protocol ListingRouterInterface{}

enum Listing{
    static func build(dependencies:ListingDependencies)->ListingViewController{
        let presenter = ListingPresenter()
        let interactor = ListingInteractor(presenter: presenter,
                                           artDetailsService: dependencies.artDetailsService,
                                           art:dependencies.art)
        let router = ListingRouter(dataStore: interactor)
        let viewController = ListingViewController(interactor: interactor,
                                                   router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
