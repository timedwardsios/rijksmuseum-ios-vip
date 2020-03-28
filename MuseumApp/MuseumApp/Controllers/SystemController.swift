import MuseumDomain
import Combine

public protocol SystemController {

    func didStart()

    func didOpenURL(_ url: URL)
}

class SystemControllerDefault {

    var appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }
}

extension SystemControllerDefault: SystemController {

    func didStart() {
        appState.routePublisher.send(.artCollection)
    }

    func didOpenURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else {
                return
        }

        for queryItem in queryItems {
            switch (queryItem.name, queryItem.value) {
            case ("showArtWithID", let value?):
                appState.routePublisher.send(.artDetails(artID: value))
                return
            default: break
            }
        }
    }
}
