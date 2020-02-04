import MuseumKit

public struct Interactors {

    let artInteractor: ArtInteractor

    public init(appState: AppState,
                services: Services) {
        self.artInteractor = ArtInteractorDefault(
            museumWebService: services.museumWebService,
            appState: appState
        )
    }
}
