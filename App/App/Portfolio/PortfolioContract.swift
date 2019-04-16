
import Foundation
import Service
import Utils

protocol PortfolioEventHandling{
    func didLoadView()
    func didPullToRefresh()
    func didTapCell(atIndex index: Int)
}

protocol PortfolioInteracting{
    func fetchArts()
}

protocol PortfolioPresentating : class{
    func didFetchArts(_ arts:[Art])
    func didError(_ error:Error)
}

protocol PortfolioDisplaying : class {
    func setIsLoading(_ isLoading:Bool)
    func setImageUrls(_ imageUrls:[URL])
    func displayErrorMessage(_ message:String)
}

//protocol PortfolioDataStoring{
//    var selectedArt:Art? {get}
//}

enum Portfolio {
    static func build() -> PortfolioViewController {
        let interactor = PortfolioInteractor(artService: DependenciesDefault.artService)
        let presenter = PortfolioPresenter(interactor: interactor)
        let display = PortfolioViewController(eventHandler: presenter)
        presenter.display = display
        interactor.presenter = presenter
        return display
    }
}


