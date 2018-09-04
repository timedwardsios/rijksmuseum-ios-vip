
import Foundation
import Service
import Utils

protocol PortfolioInteractorInput{
    func performFetchArt(request: Portfolio.FetchArt.Request)
    func performSelectArt(request: Portfolio.SelectArt.Request)
}

protocol PortfolioPresenterInput{
    func presentFetchArt(response: Portfolio.FetchArt.Response)
}

protocol PortfolioViewControllerInput:class{
    func displayFetchArt(viewModel:Portfolio.FetchArt.ViewModel)
}

protocol PortfolioRouting{
    func navigateToListing()
}

protocol PortfolioDataStore{
    var selectedArt:Art? {get}
}

typealias PortfolioViewControllerOutput = PortfolioInteractorInput
typealias PortfolioInteractorOutput = PortfolioPresenterInput
typealias PortfolioPresenterOutput = PortfolioViewControllerInput

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
        let interactor = PortfolioInteractor(output: presenter,
                                             artService: dependencies.artService)
        let router = PortfolioRouter(dataStore: interactor)
        let viewController = PortfolioViewController(output: interactor,
                                                     router: router)
        presenter.output = viewController
        router.viewController = viewController
        return viewController
    }
}
