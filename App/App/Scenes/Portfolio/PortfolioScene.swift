
import Foundation
import Service
import Utils

protocol PortfolioLogic{
    func performFetchArt(request: Portfolio.FetchArt.Request)
    func performSelectArt(request: Portfolio.SelectArt.Request)
}

protocol PortfolioPresentation{
    func presentFetchArt(response: Portfolio.FetchArt.Response)
}

protocol PortfolioDisplay:class{
    func presentFetchArt(viewModel:Portfolio.FetchArt.ViewModel)
}

protocol PortfolioRouting{
    func navigateToListingScene()
}

protocol PortfolioDataStore{
    var selectedArt:Art? {get}
}

enum Portfolio{
    enum ViewController{
        typealias Input = PortfolioDisplay
        typealias Output = Interactor.Input
    }
    enum Interactor{
        typealias Input = PortfolioLogic
        typealias Output = Presenter.Input
    }
    enum Presenter{
        typealias Input = PortfolioPresentation
        typealias Output = ViewController.Input
    }
    typealias Router = PortfolioRouter
    typealias DataStore = PortfolioDataStore

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
                                             dependencies: dependencies)
        let router = PortfolioRouter(dataStore: interactor)
        let viewController = PortfolioViewController(output: interactor,
                                                     router: router)
        presenter.output = viewController
        router.viewController = viewController
        return viewController
    }
}
