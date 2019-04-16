import UIKit
import Service

@UIApplicationMain
class AppDelegate: UIResponder {
    let window = UIWindow()
    let assembler: Assembler = AssemblerDefault()
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        setupRootViewController()
        return true
    }
}

private extension AppDelegate{
    func setupAppearance(){
        UINavigationBar.appearance().barTintColor = UIColor(hex: "40474f")
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Rijksmuseum-Bold", size: 21) as Any
        ]
        UICollectionView.appearance().backgroundColor = .clear
    }

    func setupRootViewController(){
        let portfolioViewController = Portfolio.build()
        let navController = UINavigationController(rootViewController: portfolioViewController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}

// -----------------------

typealias Assembler = PortfolioAssembler & ServiceAssembler

class AssemblerDefault: Assembler {}



protocol PortfolioAssembler {
    func resolve() -> PortfolioViewController
    func resolve() -> PortfolioInteractor
    func resolve() -> PortfolioPresenter
}

extension PortfolioAssembler where Self: Assembler {
    func resolve() -> PortfolioViewController {
        return PortfolioViewController(interactor: resolve())
    }

    func resolve() -> PortfolioInteractor {
        return PortfolioInteractor(presenter: resolve(), artService: resolve())
    }

    func resolve() -> PortfolioPresenter {
        return PortfolioPresenter(view: resolve())
    }
}



//protocol ServiceAssembler {
//    func resolve() -> ArtService
//}
//
////extension ServiceAssembler where Self: Assembler {
//extension ServiceAssembler {
//    func resolve() -> ArtService {
//        return 
//    }
//}



//protocol Assembler: SearchMoviesAssembler, MovieDetailsAssembler {}
//
//class AppAssembler: Assembler {}
//
//protocol SearchMoviesAssembler {
//    func resolve() -> SearchViewController
//
//    func resolve() -> SearchViewModelType
//
//    func resolve() -> MovieDetailsNavigatorType
//
//    func resolve() -> GetMoviesByTitleType
//
//    func resolve() -> MoviesRepositoryType
//
//    func resolve() -> MoviesRemoteDataSourceType
//
//    func resolve() -> MoviesCacheDataSourceType
//
//    func resolve() -> Networking
//}

//extension SearchMoviesAssembler where Self: Assembler {
//    func resolve() -> SearchViewController {
//        return SearchViewController(viewModel: resolve(), navigator: resolve())
//    }
//
//    func resolve() -> SearchViewModelType {
//        return SearchViewModel(getMoviesByTitle: resolve())
//    }
//
//    func resolve() -> MovieDetailsNavigatorType {
//        return MovieDetailsNavigator(assembler: self)
//    }
//
//    func resolve() -> GetMoviesByTitleType {
//        return GetMoviesByTitle(moviesRepository: resolve())
//    }
//
//    func resolve() -> MoviesRepositoryType {
//        return MoviesRepository(remoteDataSource: resolve(), cacheDataSource: resolve())
//    }
//
//    func resolve() -> MoviesRemoteDataSourceType {
//        return TMDBDataSource(network: resolve())
//    }
//
//    func resolve() -> MoviesCacheDataSourceType {
//        return MoviesCacheDataSource()
//    }
//
//    func resolve() -> Networking {
//        return Network()
//    }
//}
//
//
//
//
//
//protocol MovieDetailsAssembler {
//    func resolve(movie: Movie) -> MovieDetailsViewController
//
//    func resolve(movie: Movie) -> MovieDetailsViewModelType
//}
//
//extension MovieDetailsAssembler {
//    func resolve(movie: Movie) -> MovieDetailsViewController {
//        return MovieDetailsViewController(viewModel: resolve(movie: movie))
//    }
//
//    func resolve(movie: Movie) -> MovieDetailsViewModelType {
//        return MovieDetailsViewModel(movie: movie)
//    }
//}
