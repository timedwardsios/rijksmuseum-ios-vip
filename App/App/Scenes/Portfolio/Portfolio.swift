
import UIKit
import Utility

protocol PortfolioInteractorInput{
    func performFetchArt(request: Portfolio.FetchArt.Request)
}

protocol PortfolioPresenterInput{
    func presentFetchArt(response: Portfolio.FetchArt.Response)
}

protocol PortfolioViewControllerInput: class{
    func displayFetchArt(viewModel:Portfolio.FetchArt.ViewModel)
}

protocol PortfolioDataStore{
    var selectedArt:Art? { get }
}

protocol PortfolioRouterInput{
    var dataStore: PortfolioDataStore? { get }
}

enum Portfolio{
    enum FetchArt{
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
        let networkService = NetworkService(networkSession: URLSession.shared,
                                    networkConfig: LiveNetworkConfig())
        let artWorker = ArtWorkerNetwork(networkService: networkService)
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
