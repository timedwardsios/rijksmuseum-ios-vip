
import Service

class DependenciesDefault: Dependencies {}

protocol Dependencies {
    func resolve() -> PortfolioViewController
    func resolve(art: Art) -> ListingViewController
}

extension Dependencies {
    func resolve() -> PortfolioViewController {
        let presenter = PortfolioPresenter()
        let interactor = PortfolioInteractor(presenter: presenter, artService: resolve())
        let router = PortfolioRouter(dependencies: self, dataStore: interactor)
        let viewController = PortfolioViewController(interactor: interactor, router: router)
        presenter.view = viewController
        router.viewController = viewController
        return viewController
    }

    func resolve(art: Art) -> ListingViewController {
        let presenter = ListingPresenter()
        let interactor = ListingInteractor(presenter: presenter, art: art)
        let router = ListingRouter(dependencies: self, dataStore: interactor)
        let viewController = ListingViewController(interactor: interactor, router: router)
        presenter.view = viewController
        router.viewController = viewController
        return viewController
    }
}

import Foundation

//public protocol Dependencies {
//    func resolve() -> ArtService
//}

extension Dependencies {
//    public func resolve() -> ArtService {
//        return ArtServiceDefault(apiClient: resolve())
//    }
//
//    func resolve() -> APIClient {
//        return APIClientDefault(networkService: resolve(), apiConfig: resolve())
//    }
//
//    func resolve() -> NetworkService {
//        return NetworkServiceDefault(networkSession: resolve())
//    }
//
//    func resolve() -> NetworkSession {
//        return URLSession.shared
//    }
//
//    func resolve() -> APIConfig {
//        return APIConfigDefault()
//    }
}
