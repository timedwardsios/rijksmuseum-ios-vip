import UIKit
import Kit

@UIApplicationMain
class AppDelegate: UIResponder {

    let dependenciesDefault = DependenciesDefault()

    let window = UIWindow()
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        return true
    }
}

private extension AppDelegate {

    func setupRootViewController() {
        let portfolioViewController: PortfolioViewController = dependenciesDefault.resolve()
        let navController = UINavigationController(rootViewController: portfolioViewController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
