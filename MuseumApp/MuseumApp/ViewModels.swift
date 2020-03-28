public struct ViewModels {

    private let controllers: Controllers

    public init(controllers: Controllers) {
        self.controllers = controllers
    }

    public func artCollectionViewModel() -> ArtCollectionViewModel {
        .init(appState: appState, artController: controllers.artController)
    }

    public let artDetailsViewModel: ArtDetailsViewModel
}
