import Combine
import MuseumApp
import UIKit

public class Coordinator {

    private var subscriptions: Set<AnyCancellable> = []

    var window: UIWindow?

    var navController: UINavigationController?

    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
        bind()
    }

    func bind() {

        appState.$lifecycle
            .receive(on: RunLoop.main)
            .filter { $0 == .launched }
            .sink { _ in
                self.window = UIWindow()
                self.window?.makeKeyAndVisible()
                self.window?.rootViewController = self.navController
            }
            .store(in: &subscriptions)

        appState.$currentRoute
            .receive(on: RunLoop.main)
            .sink {
                switch $0 {
                case .artCollection:
                    let viewModel = ArtCollectionViewModel(appState: self.appState)
                    let artCollection = ArtCollectionViewController(viewModel: viewModel)
                    self.navController = UINavigationController(rootViewController: artCollection)

                case let .artDetails(artID):
                    let viewModel = ArtDetailsViewModel(artID: artID, appState: self.appState)
                    let detailsViewController = ArtDetailsViewController(viewModel: viewModel)
                    self.navController?.popToRootViewController(animated: false)
                    self.navController?.pushViewController(detailsViewController, animated: true)

                case let .alert(alert):
                    let alertController = UIAlertController(alert: alert)
                    self.navController?.present(alertController, animated: true)
                }
            }
            .store(in: &subscriptions)
    }
}
