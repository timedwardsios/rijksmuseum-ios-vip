import App
import UIKit
import Utils

let dependencies = Dependencies()

@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate {
    func application(_: UIApplication,didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        let artCollectionViewModel = ArtCollectionViewModel(useCases: dependencies.useCases)
        let artCollectionViewController = ArtCollectionViewController(viewModel: artCollectionViewModel)
        self.window?.rootViewController = artCollectionViewController
        return true
    }
}
