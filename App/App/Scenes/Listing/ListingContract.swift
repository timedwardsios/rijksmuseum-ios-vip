
import Foundation
import Services
import Utils

protocol ListingInteracting {
    func loadArtRequest(_ request:Listing.LoadArt.Request)
}

protocol ListingPresentating : class {
    func loadArtResponse(_ response:Listing.LoadArt.Response)
}

protocol ListingView : class {
    func loadArtViewModel(_ viewModel:Listing.LoadArt.ViewModel)
}

protocol ListingDataStore {}
protocol ListingRouting {}

enum Listing {
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
