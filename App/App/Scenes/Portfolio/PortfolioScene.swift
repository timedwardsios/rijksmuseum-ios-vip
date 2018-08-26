
import Foundation
import Service
import Utils

protocol PortfolioViewControllerProtocol:class{
    func displayFetchArt(viewModel:Portfolio.FetchArt.ViewModel)
}

protocol PortfolioInteractorProtocol{
    func fetchArt(request: Portfolio.FetchArt.Request)
    func selectArt(request: Portfolio.SelectArt.Request)
}

protocol PortfolioPresenterProtocol{
    func presentFetchArt(response: Portfolio.FetchArt.Response)
}

protocol PortfolioRouterProtocol{
    func navigateToListingScene()
}

protocol PortfolioDataStore{
    var selectedArt:Art? {get}
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

    typealias Dependencies = HasArtService
    static func build(dependencies:Dependencies)->PortfolioViewController{
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(presenter: presenter,
                                             dependencies: dependencies)
        let router = PortfolioRouter(dataStore: interactor)
        let viewController = PortfolioViewController(interactor: interactor,
                                                     router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
