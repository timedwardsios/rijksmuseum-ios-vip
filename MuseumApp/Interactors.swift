import MuseumDomain

public struct Interactors {

    private let systemInteractor: SystemInteractor

    public let artInteractor: ArtInteractor

    public init(services: Services) {
        self.systemInteractor = SystemControllerDefault()
        self.artInteractor = ArtInteractorDefault(webService: services.webService)
    }
}
