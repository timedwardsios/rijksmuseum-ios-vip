import Combine
import MuseumDomain

public protocol SystemController {

    func didFinishLaunching()

    func didEnterBackground()

    func willEnterForeground()

    func didOpenURL(_ url: URL)
}

public class SystemControllerDefault {

    var appState: AppState

    public init(appState: AppState) {
        self.appState = appState
    }
}

extension SystemControllerDefault: SystemController {

    public func didFinishLaunching() {
        appState.lifecycle = .launched
    }

    public func didEnterBackground() {
        appState.lifecycle = .background
    }

    public func willEnterForeground() {
        appState.lifecycle = .foreground
    }

    public func didOpenURL(_ url: URL) {
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
            case let ("showArtWithID", value?):
                appState.currentRoute = .artDetails(artID: value)
                return
            default:
                break
            }
        }
    }
}
