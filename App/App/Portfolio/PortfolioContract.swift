import Foundation
import Service

protocol PortfolioInteracting{
    func fetchArt()
    func selectArt(withIndex index:Int)
}

protocol PortfolioPresenting{
    func didBeginLoading()
    func didFetchArts(_ arts:[Art])
    func didError(_ error:Error)
}

protocol PortfolioViewing:class{
    func setViewModel(_ viewModel:PortfolioViewModel)
}

protocol PortfolioRouting{
    func navigateToListing()
}

protocol PortfolioDataStoring{
    var selectedArt:Art? {get}
}

enum Portfolio {
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
