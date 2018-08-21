
import UIKit

protocol PortfolioInteractorInput{
    func performFetchListings(request: Portfolio.FetchListings.Request)
}

protocol PortfolioPresenterInput{
    func presentFetchListings(response: Portfolio.FetchListings.Response)
}

protocol PortfolioViewControllerInput: class{
    func displayFetchListings(viewModel:Portfolio.FetchListings.ViewModel)
}

protocol PortfolioDataStore{
    var selectedArt:Art? { get }
}

protocol PortfolioRouterInput{
    var dataStore: PortfolioDataStore? { get }
}

enum Portfolio{
    enum FetchListings{
        struct Request{}
        struct Response{
            enum State {
                case loading
                case loaded([Art])
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

    static func build()->PortfolioViewController{
        let presenter = PortfolioPresenter()
        let apiService = APIService(apiSession: URLSession.shared,
                                    apiConfig: LiveAPIConfig())
        let artWorker = ArtWorkerAPI(apiService: apiService)
        let router = PortfolioRouter()
        let interactor = PortfolioInteractor(presenter: presenter,
                                             artWorker: artWorker)
        let viewController = PortfolioViewController(interactor: interactor,
                                                     router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
