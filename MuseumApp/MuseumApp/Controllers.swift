import MuseumDomain

public struct Controllers {

    public let systemController: SystemController

    public let artController: ArtController

    public init(appState: AppState,
                services: Services) {
        self.systemController = SystemControllerDefault(appState: appState)
        self.artController = ArtControllerDefault(appState: appState, webService: services.webService)
    }
}
