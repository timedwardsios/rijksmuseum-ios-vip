import UIKit
import MuseumApp
import Utils

@UIApplicationMain
class AppDelegate: UIResponder {

    let dependencies: Dependencies
    let systemController: SystemController

    override init() {
        self.dependencies = Dependencies()
        self.systemController = dependencies.systemController
        super.init()
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        systemController.didStart()
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        systemController.didOpenURL(url)
        return true
    }
}
