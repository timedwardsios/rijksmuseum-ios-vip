import Foundation
import MuseumKit
import Combine

public class ArtCollectionInteractor {

    @Published public private(set) var arts: [Art] = []

    @Published public var isAppeared = false
    @Published public var isRequestingRefresh = false
    @Published public var selectedArt: Art? = nil

    private var tokens: Set<AnyCancellable> = []

    private var appState: AppState
    private let museumWebService: MuseumWebService
    init(appState: AppState,
         museumWebService: MuseumWebService) {
        self.appState = appState
        self.museumWebService = museumWebService
        bind()
    }

    func bind() {
        appState.$arts
            .assign(to: \.arts, on: self)
            .store(in: &tokens)

        $isAppeared
            .merge(with: $isRequestingRefresh)
            .filter { $0 == true }
            .setFailureType(to: Error.self)
            .flatMap { _ in self.museumWebService.fetchArt() }
            .assertNoFailure()
            .assign(to: \.arts, on: appState)
            .store(in: &tokens)

        $selectedArt
            .compactMap { $0?.id }
            .map { .artDetails(artID: $0) }
            .subscribe(appState.routePublisher)
            .store(in: &tokens)
    }
}

extension ArtCollectionInteractor {
    struct Routing {
        var selectedArtID: String? = nil
    }
}
