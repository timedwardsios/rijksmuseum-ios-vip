import UIKit
import MuseumApp
import Combine

public class Coordinator {

    private var subscriptions: Set<AnyCancellable> = []

    var window: UIWindow?
    var navController: UINavigationController?

    private let appState: AppState
    private let viewModels: ViewModels

    init(appState: AppState,
         viewModels: ViewModels) {
        self.appState = appState
        self.viewModels = viewModels
        bind()
    }

    func bind() {
        appState.routePublisher
            .receive(on: RunLoop.main)
            .sink {
                switch $0 {
                case .artCollection:
                    let artCollection = ArtCollectionViewController(viewModel: self.viewModels.artCollectionViewModel)
                    self.navController = UINavigationController(rootViewController: artCollection)
                    self.window = UIWindow()
                    self.window?.rootViewController = self.navController
                    self.window?.makeKeyAndVisible()

                case .artDetails(let artID):
                    let detailsViewController = ArtDetailsViewController(artID: artID, viewModel: self.viewModels.artDetailsInteractor)
                    self.navController?.popToRootViewController(animated: false)
                    self.navController?.pushViewController(detailsViewController, animated: true)

                case .alert(let alert):
                    let alertController = UIAlertController(alert: alert)
                    self.navController?.present(alertController, animated: true)
                } }
            .store(in: &subscriptions)
    }
}
