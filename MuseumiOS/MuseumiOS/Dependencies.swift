import MuseumApp
import MuseumKit

struct Dependencies {

    let router: Router
    let systemEventHandler: SystemEventHandler

    init() {
        let appState = AppState()
        let services = Services()
        let interactors = Interactors(appState: appState, services: services)
        let presenters = Presenters(appState: appState, interactors: interactors)
        self.systemEventHandler = presenters.systemEventHandler
        self.router = Router(appState: appState, presenters: presenters)
    }
}
