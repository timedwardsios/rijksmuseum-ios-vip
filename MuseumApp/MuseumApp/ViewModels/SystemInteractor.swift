import MuseumDomain
import RxSwift
import RxRelay

public protocol SystemInteractor {
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

extension SystemControllerDefault: SystemInteractor {
    public func didFinishLaunching() {
        appState.lifecycle.accept(.launched)
    }

    public func didEnterBackground() {
        appState.lifecycle.accept(.background)
    }

    public func willEnterForeground() {
        appState.lifecycle.accept(.foreground)
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
                appState.currentRoute.accept(.artDetails(artID: value))
                return
            default:
                break
            }
        }
    }
}
