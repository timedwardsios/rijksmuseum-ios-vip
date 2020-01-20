import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
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
        let portfolioViewController: PortfolioViewController = resolve()
        let navController = UINavigationController(rootViewController: portfolioViewController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
