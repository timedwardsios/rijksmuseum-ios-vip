import Foundation
import Service
import Utils

protocol PortfolioInteraction{
    func performFetchArts()
    func performSelectArt(withIndex index:Int)
}

protocol PortfolioPresentation{
    func presentArts(state: State<[Art], Error>)
}

protocol PortfolioDisplay:class{
    func displayArts(state: State<[URL], String>)
}

protocol PortfolioRouting{
    func routeToListing()
}

protocol PortfolioDataStoring{
    var selectedArt:Art? {get}
}

enum Portfolio {
    typealias Dependencies = HasArtService
    static func build(dependencies:Dependencies)->PortfolioDisplay{
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(presentation: presenter,
                                             artService: dependencies.artService)
        let router = PortfolioRouter(dataStore: interactor)
        let viewController = PortfolioDisplay(interacting: interactor,
                                              routing: router)
        presenter.view = viewController
        router.viewController = viewController
        return viewController
    }
}


