
import UIKit

// MARK: protocols
protocol PortfolioInteractorInterface{
    func performFetchListings(request: Portfolio.FetchListings.Request)
}

protocol PortfolioPresenterInterface{
    func presentFetchListings(response: Portfolio.FetchListings.Response)
}

protocol PortfolioViewControllerInterface: class{
    func displayFetchListings(viewModel:Portfolio.FetchListings.ViewModel)
}

protocol PortfolioDataStore{
    var selectedArtPrimitive:ArtPrimitive? { get }
}

protocol PortfolioRouterInterface{
    var dataStore: PortfolioDataStore? { get }
}

// MARK: use-cases
enum Portfolio{
    enum FetchListings{
        struct Request{}
        struct Response{
            enum State {
                case loading
                case loaded([ArtPrimitive])
                case error(Error)
            }
            let state:State
        }
        struct ViewModel{
            enum State {
                case loading
                case loaded([URL])
                case error(String)
            }
            let state:State
        }
    }

//    enum HighlightListing{
//        struct Request{}
//        struct Response{}
//        struct ViewModel{
//            let highlightedIndex:Int
//        }
//    }

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
