import App
import UIKit
import Utils

let dependencies = Dependencies()

@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?

    var viewModel = AppViewModel()
}

extension AppDelegate: UIApplicationDelegate {
    func application(_: UIApplication,didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        let artCollectionViewController = ArtCollectionViewController(viewModel: ArtCollectionViewModel(useCases: dependencies.useCases))
        self.window?.rootViewController = artCollectionViewController
        return true
    }

    func applicationDidEnterBackground(_: UIApplication) {
        //
    }

    func applicationWillEnterForeground(_: UIApplication) {
        //
    }

    func application(
        _: UIApplication,
        open url: URL,
        options _: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
//        systemController.didOpenURL(url)
        return true
    }
}
