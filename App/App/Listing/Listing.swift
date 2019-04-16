
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
}
