import UIKit
import MuseumApp
import TimKit

@UIApplicationMain
class AppDelegate: UIResponder {

    let dependencies: Dependencies
    let systemInteractor: SystemInteractor

    override init() {
        self.dependencies = Dependencies()
        self.systemInteractor = dependencies.systemInteractor
        super.init()
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        systemInteractor.didStart()
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        systemInteractor.didOpenURL(url)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        systemInteractor.willResignActive()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        systemInteractor.didBecomeActive()
    }
}
