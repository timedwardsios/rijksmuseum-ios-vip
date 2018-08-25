
import UIKit
import Services
import Utilities

protocol PortfolioDependencies{
    var artService:ArtServiceInterface{get}
}

protocol PortfolioDataStore{
    var selectedArt:Art? {get}
}

protocol PortfolioInteractorInterface:PortfolioDataStore{
    func fetchArt(request: Portfolio.FetchArt.Request)
    func selectArt(request: Portfolio.SelectArt.Request)
}

protocol PortfolioPresenterInterface{
    func didFetchArt(response: Portfolio.FetchArt.Response)
}

protocol PortfolioViewControllerInterface: class{
    func displayFetchArt(viewModel:Portfolio.FetchArt.ViewModel)
}

protocol PortfolioRouterInterface{
    func navigateToListingScene()
}

enum Portfolio{
    enum FetchArt{
        struct Request{}
        struct Response{
            enum State {
                case loading
                case loaded([Art])
                case error(ResultError)
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

    enum SelectArt{
        struct Request{
            let index:Int
        }
        struct Response{}
        struct ViewModel{}
    }

    static func buildScene()->PortfolioViewController{
        let presenter = PortfolioPresenter()
        let apiService = APIService(apiSession: URLSession.shared,
                                    apiConfig: LiveAPIConfig())
        let artService = ArtServiceAPI(apiService: apiService)
        let interactor = PortfolioInteractor(presenter: presenter,
                                             artService: artService)
        let router = PortfolioRouter(dataStore: interactor)
        let viewController = PortfolioViewController(interactor: interactor,
                                                     router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
