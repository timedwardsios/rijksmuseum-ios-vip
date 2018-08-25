
import UIKit
import Service

@UIApplicationMain
class AppDelegate: UIResponder {
    let window = UIWindow()
    override init() {
        UIWindow.appearance().backgroundColor = UIColor(hex: "343537")
        UINavigationBar.appearance().barTintColor = UIColor(hex: "40474f")
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Rijksmuseum-Bold", size: 22) as Any
        ]
        UICollectionView.appearance().backgroundColor = .clear
        window.backgroundColor = UIWindow.appearance().backgroundColor // workaround
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let portfolioViewController = PortfolioScene.build(dependencies: AppDependencies())
        let navController = UINavigationController(rootViewController: portfolioViewController)
        window.rootViewController = navController
        window.frame = UIScreen.main.bounds
        window.makeKeyAndVisible()
        return true
    }
}
