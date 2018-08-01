
import UIKit

enum Portfolio{
    enum FetchListings{
        struct Request{}
        struct Response{
            let result:Result<[ArtPrimitive], Error>
        }
        struct ViewModel{
            enum ViewState {
                case loading
                case refreshed
                case loaded
                case error(String)
            }
            let viewState:ViewState
            let hightlightedIndex:Int?
        }
    }

    static func build()->PortfolioViewController{
        let presenter = PortfolioPresenter()
        let artPrimitiveAPI = ArtPrimitiveAPI()
        let router = PortfolioRouter()
        let artPrimitiveWorker = ArtPrimitiveWorker(artPrimitiveSource: artPrimitiveAPI)
        let interactor = PortfolioInteractor(presenter: presenter,
                                             artPrimitiveWorker: artPrimitiveWorker)
        let viewController = PortfolioViewController(interactor: interactor,
                                                     router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
