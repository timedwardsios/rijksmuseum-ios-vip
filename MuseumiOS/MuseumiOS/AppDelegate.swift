import MuseumApp
import UIKit
import Utils

@UIApplicationMain
class AppDelegate: UIResponder {

    let appState: AppState
    let systemController: SystemController
    let coordinator: Coordinator

    override convenience init() {
        let appState = AppState()
        self.init(
            appState: AppState(),
            systemController: SystemControllerDefault(appState: appState),
            coordinator: Coordinator(appState: appState)
        )
    }

    init(
        appState: AppState,
        systemController: SystemController,
        coordinator: Coordinator
    ) {
        self.appState = appState
        self.systemController = systemController
        self.coordinator = coordinator
        super.init()
    }
}

extension AppDelegate: UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        systemController.didFinishLaunching()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        systemController.didEnterBackground()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        systemController.willEnterForeground()
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        systemController.didOpenURL(url)
        return true
    }
}
