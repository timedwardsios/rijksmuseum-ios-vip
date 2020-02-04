import UIKit
import MuseumApp
import TimKit

@UIApplicationMain
class AppDelegate: UIResponder {

    let dependencies: Dependencies
    let systemEventHandler: SystemEventHandler

    override init() {
        self.dependencies = Dependencies()
        self.systemEventHandler = dependencies.systemEventHandler
        super.init()
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        systemEventHandler.didStart()
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        systemEventHandler.didOpenURL(url)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        systemEventHandler.willResignActive()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        systemEventHandler.didBecomeActive()
    }
}
