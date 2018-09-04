
import UIKit
import Service
import Utils

protocol ListingInteractorInput{
    func performLoadArt(request: Listing.LoadArt.Request)
}

protocol ListingPresenterInput{
    func presentLoadArt(response: Listing.LoadArt.Response)
}

protocol ListingViewControllerInput: class{
    func displayLoadArt(viewModel:Listing.LoadArt.ViewModel)
}

protocol ListingRouterProtocol{}

protocol ListingDataStore{}

typealias ListingViewControllerOutput = ListingInteractorInput
typealias ListingInteractorOutput = ListingPresenterInput
typealias ListingPresenterOutput = ListingViewControllerInput

enum Listing{
    enum LoadArt{
        struct Request{}
        struct Response{
            let art:Art
        }
        struct ViewModel{
            let imageUrl:URL
        }
    }

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
