import MuseumApp
import MuseumDomain

struct Dependencies {

    let coordinator: Coordinator
    let systemController: SystemInteractor

    init() {
        let appState = AppState()
        let services = Services()
        let controllers = Controllers(appState: appState, services: services)
        let viewModels = ViewModels(appState: appState, controllers: controllers)
        self.coordinator = Coordinator(appState: appState, viewModels: viewModels)
        self.systemController = controllers.systemController
    }
}
