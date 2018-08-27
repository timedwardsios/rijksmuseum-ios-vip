
import UIKit
import Service
import Utils

protocol PortfolioInteractorInput{
    func executeFetchArt(request: PortfolioScene.FetchArt.Request)
    func executeSelectArt(request: PortfolioScene.SelectArt.Request)
}

protocol PortfolioPresenterInput{
    func presentFetchArt(response: PortfolioScene.FetchArt.Response)
    func presentSelectArt(response: PortfolioScene.SelectArt.Response)
}

protocol PortfolioViewControllerInput:class{
    func displayFetchArt(viewModel:PortfolioScene.FetchArt.ViewModel)
}

protocol PortfolioRouter:class{
    func didSelectArt(_ art:Art)
}

typealias PortfolioViewControllerOutput = PortfolioInteractorInput
typealias PortfolioInteractorOutput = PortfolioPresenterInput
typealias PortfolioPresenterOutput = PortfolioViewControllerInput

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
        struct Response{
            let art:Art
        }
        struct ViewModel{}
    }

    typealias Dependencies = HasArtService
    static func build(dependencies:Dependencies,
                      router: PortfolioRouter)->UIViewController{
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(output: presenter,
                                             artService: dependencies.artService)
        let viewController = PortfolioViewController(output: interactor)
        presenter.output = viewController
        presenter.router = router
        return viewController
    }
}
