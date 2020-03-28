import MuseumDomain
import Combine

public protocol SystemController {

    func didFinishLaunching()

    func didEnterBackground()

    func willEnterForeground()

    func didOpenURL(_ url: URL)

}

class SystemControllerDefault {

    var appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }
}

extension SystemControllerDefault: SystemController {

    func didFinishLaunching() {
        appState.lifecycle = .launched
    }

    func didEnterBackground() {
        appState.lifecycle = .background
    }

    func willEnterForeground() {
        appState.lifecycle = .foreground
    }

    func didOpenURL(_ url: URL) {
        handleDeepLink(withURL: url)
    }
}

private extension SystemControllerDefault {
    func handleDeepLink(withURL url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else {
                return
        }

        for queryItem in queryItems {
            switch (queryItem.name, queryItem.value) {
            case ("showArtWithID", let value?):
                appState.currentRoute = .artDetails(artID: value)
                return
            default: break
            }
        }
    }
}
