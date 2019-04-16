
import Foundation
import Service
import Utils

protocol PortfolioInteracting{
    func fetchArts()
    func selectArt(withIndex index:Int)
}

protocol PortfolioPresentating{
    func didStartLoading()
    func didFetchArts(_ arts:[Art])
    func didError(_ error:Error)
}

protocol PortfolioView:class{
    func setViewModel(_ viewModel:PortfolioViewModel)
}

protocol PortfolioRouting{
    func routeToListing()
}

protocol PortfolioDataStoring{
    var selectedArt:Art? {get}
}

enum Portfolio {
    typealias Dependencies = HasArtService
    static func build(dependencies:Dependencies) -> PortfolioViewController {
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(presenting: presenter,
                                             artService: dependencies.artService)
        let router = PortfolioRouter(dataStore: interactor)
        let viewController = PortfolioViewController(interacting: interactor,
                                                     routing: router)
        presenter.view = viewController
        router.viewController = viewController
        return viewController
    }
}


