import MuseumApp
import UIKit
import RxSwift

public class Coordinator {
    private let disposeBag = DisposeBag()

    var window: UIWindow?

    var navController: UINavigationController?

    init() {
        bind()
    }

    func bind() {

//        appState.lifecycle
//            .asDriver()
//            .filter { $0 == .launched }
//            .drive(onNext: { _ in
//                self.window = UIWindow()
//                self.window?.makeKeyAndVisible()
//                self.window?.rootViewController = self.navController
//            })
//            .disposed(by: disposeBag)
//
//        appState.currentRoute
//            .asDriver()
//            .drive(onNext: {
//                switch $0 {
//                case .artCollection:
//                    let viewModel = ArtCollectionViewModel(appState: self.appState)
//                    let artCollection = ArtCollectionViewController(viewModel: viewModel)
//                    self.navController = UINavigationController(rootViewController: artCollection)
//
//                case let .artDetails(artID):
//                    let viewModel = ArtDetailsViewModel(artID: artID)
//                    let detailsViewController = ArtDetailsViewController(viewModel: viewModel)
//                    self.navController?.popToRootViewController(animated: false)
//                    self.navController?.pushViewController(detailsViewController, animated: true)
//
//                case let .alert(alert):
//                    let alertController = UIAlertController(alert: alert)
//                    self.navController?.present(alertController, animated: true)
//                }
//            }).disposed(by: disposeBag)
    }
}
