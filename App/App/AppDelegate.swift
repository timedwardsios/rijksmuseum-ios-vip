
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    let window = UIWindow()
    override init() {
        UIWindow.appearance().backgroundColor = UIColor(hex: "343537")
        UINavigationBar.appearance().barTintColor = UIColor(hex: "40474f")
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "Rijksmuseum-Bold", size: 22) as Any
        ]
        UICollectionView.appearance().backgroundColor = .clear
        window.backgroundColor = UIWindow.appearance().backgroundColor // workaround
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let portfolioViewController = Portfolio.build()
        let navigationController = UINavigationController(rootViewController: portfolioViewController)
        window.rootViewController = navigationController
        window.frame = UIScreen.main.bounds
        window.makeKeyAndVisible()
        return true
    }
}
