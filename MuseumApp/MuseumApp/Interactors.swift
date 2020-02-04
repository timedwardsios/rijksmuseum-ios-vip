import MuseumKit

public struct Interactors {

    public let systemInteractor: SystemInteractor
    public let artCollectionInteractor: ArtCollectionInteractor
    public let artDetailsInteractor: ArtDetailsInteractor

    public init(appState: AppState,
                services: Services) {
        self.systemInteractor = SystemInteractorDefault(appState: appState)
        self.artCollectionInteractor = .init(appState: appState, museumWebService: services.museumWebService)
        self.artDetailsInteractor = .init(appState: appState)
    }
}
