import MuseumApp
import UIKit
import Utils

@UIApplicationMain
class AppDelegate: UIResponder {

    let appState: AppState
    let systemController: SystemController
    let coordinator: Coordinator

    convenience override init() {
        let appState = AppState()
        self.init(appState: AppState(),
                  systemController: SystemControllerDefault(appState: appState),
                  coordinator: Coordinator(appState: appState))
    }

    init(appState: AppState, systemController: SystemController, coordinator: Coordinator) {
        self.appState = appState
        self.systemController = systemController
        self.coordinator = coordinator
        super.init()
    }
}

extension AppDelegate: UIApplicationDelegate {

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        systemController.didFinishLaunching()
        return true
    }

    func applicationDidEnterBackground(_: UIApplication) {
        systemController.didEnterBackground()
    }

    func applicationWillEnterForeground(_: UIApplication) {
        systemController.willEnterForeground()
    }

    func application(_: UIApplication,
                     open url: URL,
                     options _: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        systemController.didOpenURL(url)
        return true
    }
}
