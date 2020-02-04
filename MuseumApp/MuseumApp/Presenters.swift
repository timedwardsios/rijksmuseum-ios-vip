public struct Presenters {

    public let artCollectionPresenter: ArtCollectionPresenter

    public let artDetailsPresenter: ArtDetailsPresenter

    public let systemEventHandler: SystemEventHandler

    public init(appState: AppState,
         interactors: Interactors) {

        self.artCollectionPresenter = ArtCollectionPresenter(
            appState: appState,
            artInteractor: interactors.artInteractor
        )

        self.artDetailsPresenter = ArtDetailsPresenter(appState: appState)

        self.systemEventHandler = SystemEventHandlerDefault(appState: appState)
    }
}
