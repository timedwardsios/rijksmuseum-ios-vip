import MuseumDomain
import Combine

public protocol SystemInteractor {

    func didStart()

    func didOpenURL(_ url: URL)

    func willResignActive()

    func didBecomeActive()
}

class SystemInteractorDefault {

    var appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }
}

extension SystemInteractorDefault: SystemInteractor {

    func didStart() {
        appState.routePublisher.send(.artCollection)
    }

    func didOpenURL(_ url: URL) {
        if let deepLink = DeepLink(url: url) {
            handleDeepLink(deepLink)
        }
    }

    func didBecomeActive() {
        appState.isActive = true
    }

    func willResignActive() {
        appState.isActive = false
    }
}

private extension SystemInteractorDefault {
    func handleDeepLink(_ deepLink: DeepLink) {
        switch deepLink {
        case .showArtWithID(let id):
            appState.routePublisher.send(.artDetails(artID: id))
        }
    }
}
