import UIKit
import MuseumApp
import Combine

public class Router {

    private var tokens: Set<AnyCancellable> = []

    var window: UIWindow?

    private let appState: AppState
    private let presenters: Presenters

    init(appState: AppState,
         presenters: Presenters) {
        self.appState = appState
        self.presenters = presenters
        bind()
    }

    func bind() {
        appState.$isActive
            .filter { $0 == true }
            .flatMap { _ in self.appState.$currentRoute }
            .sink {
                switch $0 {
                case .artCollection:
                    let artCollection = ArtCollectionViewController(presenter: self.presenters.artCollectionPresenter)
                    let navController = UINavigationController(rootViewController: artCollection)
                    self.window = UIWindow()
                    self.window?.rootViewController = navController
                    self.window?.makeKeyAndVisible()
                case .artDetails(let selectedArtID):
                    guard let navController = self.window?.rootViewController as? UINavigationController else {
                        return
                    }
                    let detailsViewController = ArtDetailsViewController(artID: selectedArtID, presenter: self.presenters.artDetailsPresenter)
                    navController.pushViewController(detailsViewController, animated: true)
                }
        }.store(in: &tokens)


    }
}
