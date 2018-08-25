
import UIKit
import Service
import Utils

protocol PortfolioDataStore{
    var selectedArt:Art? {get}
}

protocol PortfolioInteractorProtocol:PortfolioDataStore{
    func fetchArt(request: PortfolioScene.FetchArt.Request)
    func selectArt(request: PortfolioScene.SelectArt.Request)
}

protocol PortfolioPresenterProtocol{
    func didFetchArt(response: PortfolioScene.FetchArt.Response)
}

protocol PortfolioViewControllerProtocol: class{
    func displayFetchArt(viewModel:PortfolioScene.FetchArt.ViewModel)
}

protocol PortfolioRouterProtocol{
    func navigateToListingScene()
}

enum PortfolioScene{
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
                                             artService: dependencies.artService)
        let router = PortfolioRouter(dataStore: interactor)
        let viewController = PortfolioViewController(interactor: interactor,
                                                     router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
