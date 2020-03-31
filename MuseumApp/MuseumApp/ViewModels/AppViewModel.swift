import MuseumCore
import RxSwift
import RxRelay

public class AppViewModel {

    public struct Inputs {
        public let didFinishLaunching = PublishRelay<Void>()
        public let didEnterBackground = PublishRelay<Void>()
        public let willEnterForeground = PublishRelay<Art>()
        public let didOpenURL = PublishRelay<URL>()
    }

    public let inputs = Inputs()
}

extension AppViewModel {
    public func didFinishLaunching() {
//        appState.lifecycle.accept(.launched)
    }

    public func didEnterBackground() {
//        appState.lifecycle.accept(.background)
    }

    public func willEnterForeground() {
//        appState.lifecycle.accept(.foreground)
    }

    public func didOpenURL(_ url: URL) {
        handleDeepLink(withURL: url)
    }
}

private extension AppViewModel {
    func handleDeepLink(withURL url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else {
            return
        }

        for queryItem in queryItems {
            switch (queryItem.name, queryItem.value) {
            case let ("showArtWithID", value?):
//                appState.currentRoute.accept(.artDetails(artID: value))
                return
            default:
                break
            }
        }
    }
}
