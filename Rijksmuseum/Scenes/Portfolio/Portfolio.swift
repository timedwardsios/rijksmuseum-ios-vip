
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
                case loaded([URL])
                case highlighted(Int)
                case error(String)
            }
            let viewState:ViewState
        }
    }

    static func build()->PortfolioViewController{
        let presenter = PortfolioPresenter()
        let apiService = APIService(apiSession: URLSession.shared,
                                    apiConfig: LiveAPIConfig())
        let artPrimitiveWorker = ArtPrimitiveAPIWorker(apiService: apiService)
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
