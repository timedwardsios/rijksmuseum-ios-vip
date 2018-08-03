
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
                case loaded(Bool)//newData
                case error(String)//message
            }
            let viewState:ViewState
            let highlightedIndex:Int?
        }
    }

    static func build()->PortfolioViewController{
        let presenter = PortfolioPresenter()
        let apiClient = APIClient(networkSession: URLSession.shared,
                                  apiConfig: APIData.Live.Config())
        let artPrimitiveWorker = ArtPrimitiveAPIWorker(apiClient: apiClient)
        let router = PortfolioRouter()
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
