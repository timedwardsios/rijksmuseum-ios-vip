import UIKit
import MuseumApp
import Combine

public class Coordinator {

    private var tokens: Set<AnyCancellable> = []

    var window: UIWindow?
    var navController: UINavigationController?

    private let appState: AppState
    private let interactors: Interactors

    init(appState: AppState,
         interactors: Interactors) {
        self.appState = appState
        self.interactors = interactors
        bind()
    }

    /*
     Note the "previous" value of route is unreliable as we have no way of hooking into "back"
     navigation events: https://github.com/ReSwift/ReSwift-Router/issues/17
     This somewhat breaks our idea of centralised state but with UIKit there's no alternative.
     */

    func bind() {
        appState.routePublisher
            .sink {
                switch $0 {
                case .artCollection:
                    let artCollection = ArtCollectionViewController(
                        interactor: self.interactors.artCollectionInteractor
                    )
                    self.navController = UINavigationController(
                        rootViewController: artCollection
                    )
                    self.window = UIWindow()
                    self.window?.rootViewController = self.navController
                    self.window?.makeKeyAndVisible()

                case .artDetails(let artID):
                    let detailsViewController = ArtDetailsViewController(
                        artID: artID,
                        interactor: self.interactors.artDetailsInteractor
                    )
                    self.navController?.popToRootViewController(animated: false)
                    self.navController?.pushViewController(detailsViewController, animated: true)

                case .alert(let alert):
                    let alertController = UIAlertController(alert: alert)
                    self.navController?.present(alertController, animated: true)
                } }
            .store(in: &tokens)
    }
}
