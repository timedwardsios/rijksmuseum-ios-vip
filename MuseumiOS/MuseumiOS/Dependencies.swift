import MuseumApp
import MuseumKit

struct Dependencies {

    let coordinator: Coordinator
    let systemInteractor: SystemInteractor

    init() {
        let appState = AppState()
        let services = Services()
        let interactors = Interactors(appState: appState, services: services)
        let viewModels = ViewModels(appState: appState, interactors: interactors)
        self.coordinator = Coordinator(appState: appState, viewModels: viewModels)
        self.systemInteractor = interactors.systemInteractor
    }
}
