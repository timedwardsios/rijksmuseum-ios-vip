import UIKit
import Service

@UIApplicationMain
class AppDelegate: UIResponder {
    let window = UIWindow()
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        setupRootViewController()
        return true
    }
}

private extension AppDelegate{
    func setupAppearance(){
        UINavigationBar.appearance().barTintColor = UIColor(hex: "40474f")
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Rijksmuseum-Bold", size: 21) as Any
        ]
        UICollectionView.appearance().backgroundColor = .clear
    }

    func setupRootViewController(){
        let portfolioViewController = Portfolio.build()
        let navController = UINavigationController(rootViewController: portfolioViewController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
