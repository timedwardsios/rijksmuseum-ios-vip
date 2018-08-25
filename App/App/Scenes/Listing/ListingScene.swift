
import UIKit
import Services
import Utilities

protocol ListingDataInput{
    var art:Art{get}
}

protocol ListingDataStore{}

protocol ListingInteractorInterface{}

protocol ListingPresenterInterface{}

protocol ListingViewControllerInterface: class{}

protocol ListingRouterInterface{}

enum Listing{
    typealias Dependencies = HasArtDetailsService
    static func build(dependencies:Dependencies,
                      art:Art)->ListingViewController{
        let presenter = ListingPresenter()
        let interactor = ListingInteractor(presenter: presenter,
                                           artDetailsService: dependencies.artDetailsService,
                                           art:art)
        let router = ListingRouter(dataStore: interactor)
        let viewController = ListingViewController(interactor: interactor,
                                                   router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
