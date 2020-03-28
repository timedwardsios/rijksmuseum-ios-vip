import MuseumDomain

public struct ViewModels {

    public let artCollectionViewModel: ArtCollectionViewModel
    public let artDetailsViewModel: ArtDetailsViewModel

    public init(appState: AppState,
                controllers: Controllers) {
        self.artCollectionViewModel = .init(appState: appState, artController: controllers.artController)
        self.artDetailsViewModel = .init(appState: appState)
    }
}

public struct Controllers {
    public let systemController: SystemController
    public let artController: ArtController

    public init(appState: AppState,
                services: Services) {
        self.systemController = SystemControllerDefault(appState: appState)
        self.artController = ArtControllerDefault(appState: appState, webService: services.webService)
    }
}
