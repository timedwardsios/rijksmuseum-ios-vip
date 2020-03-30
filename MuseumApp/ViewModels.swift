public struct ViewModels {

    private let interactors: Interactors

    public init(controllers: Interactors) {
        self.interactors = controllers
    }

    public func artCollectionViewModel() -> ArtCollectionViewModel {
        .init(appState: appState, artController: controllers.artController)
    }

    public let artDetailsViewModel: ArtDetailsViewModel
}
