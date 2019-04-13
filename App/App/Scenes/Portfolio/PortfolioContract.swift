
import Foundation
import Service
import Utils

protocol PortfolioView:class{
    func setViewModel(_ viewModel:Portfolio.ViewModel)
}

protocol PortfolioInteracting{
    func performFetchArt(request: Portfolio.FetchArt.Request)
}

protocol PortfolioPresenting{
    func presentFetchArt(response: Portfolio.FetchArt.Response)
}

protocol PortfolioRouting{
    func navigateToListing()
}

protocol PortfolioDataStoring{
    var selectedArt:Art? {get}
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
    }

    enum SelectArt{
        struct Request{
            let index:Int
        }
        struct Response{}
    }

    struct ViewModel {
        enum State {
            case loading
            case loaded([URL])
            case error(String)
        }
        let state:State
    }

    typealias Dependencies = HasArtService
    static func build(dependencies:Dependencies)->PortfolioViewController{
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(presenter: presenter,
                                             artService: dependencies.artService)
        let router = PortfolioRouter(dataStore: interactor)
        let viewController = PortfolioViewController(interactor: interactor,
                                                     router: router)
        presenter.view = viewController
        router.viewController = viewController
        return viewController
    }
}
