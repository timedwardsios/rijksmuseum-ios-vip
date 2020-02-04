import MuseumApp
import MuseumKit

struct Dependencies {

    let coordinator: Coordinator
    let systemInteractor: SystemInteractor

    init() {
        let appState = AppState()
        let services = Services()
        let interactors = Interactors(appState: appState, services: services)
        self.coordinator = Coordinator(appState: appState, interactors: interactors)
        self.systemInteractor = interactors.systemInteractor
    }
}
