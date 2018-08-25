
import UIKit
import Service
import Utils

protocol ListingDataStore{}

protocol ListingInteractorProtocol{}

protocol ListingPresenterProtocol{}

protocol ListingViewControllerProtocol: class{}

protocol ListingRouterProtocol{}

enum ListingScene{
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
