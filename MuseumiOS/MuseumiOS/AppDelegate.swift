import UIKit
import MuseumApp
import Utils

@UIApplicationMain
class AppDelegate: UIResponder {

    let systemController: SystemController

    init(systemController: SystemController) {
        self.systemController = systemController
        super.init()
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        systemController.didFinishLaunching()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        systemController.didEnterBackground()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        systemController.willEnterForeground()
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        systemController.didOpenURL(url)
        return true
    }
}
