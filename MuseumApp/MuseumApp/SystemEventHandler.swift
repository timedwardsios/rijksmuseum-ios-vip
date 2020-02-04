import MuseumKit
import Combine

public protocol SystemEventHandler {

    func didStart()

    func didOpenURL(_ url: URL)

    func willResignActive()

    func didBecomeActive()
}

class SystemEventHandlerDefault {

    var appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }
}

extension SystemEventHandlerDefault: SystemEventHandler {

    func didStart() {
        appState.currentRoute = .artCollection
    }

    func didOpenURL(_ url: URL) {
        if let deepLink = DeepLink(url: url) {
            handleDeepLink(deepLink)
        }
    }

    func willResignActive() {
        appState.isActive = false
    }

    func didBecomeActive() {
        appState.isActive = true
    }
}

private extension SystemEventHandlerDefault {
    func handleDeepLink(_ deepLink: DeepLink) {
        switch deepLink {
        case .showArtWithID(let id):
            appState.currentRoute = .artDetails(selectedArtID: id)
        }
    }
}
