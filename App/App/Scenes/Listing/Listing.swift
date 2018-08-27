
import UIKit
import Service
import Utils

protocol ListingViewControllerInput: class{}

protocol ListingInteractorInput{}

protocol ListingPresenterInput{}

protocol ListingRouterProtocol{}

protocol ListingDataStore{}

typealias ListingViewControllerOutput = ListingInteractorInput
typealias ListingInteractorOutput = ListingPresenterInput
typealias ListingPresenterOutput = ListingViewControllerInput

enum Listing{
    typealias Dependencies = HasArtDetailsService
    static func build(dependencies:Dependencies,
                      art:Art)->ListingViewController{
        let presenter = ListingPresenter()
        let interactor = ListingInteractor(output: presenter,
                                           artDetailsService: dependencies.artDetailsService,
                                           art:art)
        let router = ListingRouter(dataStore: interactor)
        let viewController = ListingViewController(output: interactor,
                                                   router: router)
        presenter.output = viewController
        router.viewController = viewController
        return viewController
    }
}
