
import Foundation
import Service
import Utils




import UIKit

protocol View: UIViewController {
    associatedtype ViewModel
    associatedtype Interactor
    var interactor: Interactor {get}
    init(interactor: Interactor)

    func processViewModel(_ viewModel:ViewModel)
}

protocol Interactor {
    associatedtype Presenter
    associatedtype Request
    var presenter: Presenter {get}
    init(presenter: Presenter)
    func processRequest(_ request:Request)
}

protocol Presenter {
    associatedtype View
    associatedtype Response
    var view: View {get}
    init(view: View)
    func processResponse(_ response:Response)
}




enum FooRequest{
    case one
    case two
}

enum FooResponse{
    case three
    case four
}

struct FooViewModel{
    let name:String
}

class FooView: UIViewController, View {
    typealias ViewModel = FooViewModel
    typealias Interactor = FooInteractor

    var interactor: FooInteractor

    required init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func processViewModel(_ viewModel: FooViewModel) {
        // success
    }
}

class FooPresenter: Presenter {
    typealias View = FooView
    typealias Response = FooResponse

    let view: View

    required init(view: View) {
        self.view = view
    }

    func processResponse(_ response: FooResponse) {
        // success
    }
}

class FooInteractor: Interactor {
    typealias Presenter = FooPresenter
    typealias Request = FooRequest

    let presenter: FooPresenter

    required init(presenter: Presenter) {
        self.presenter = presenter
    }

    func processRequest(_ request: FooRequest) {
        // success
    }
}

func buildScene<V:View, I:Interactor, P:Presenter>(view:V, interactor:I, presenter:P){

}








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
