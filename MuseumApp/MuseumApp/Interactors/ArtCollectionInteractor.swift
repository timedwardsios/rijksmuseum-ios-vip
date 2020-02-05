import Foundation
import MuseumKit
import Combine
import TimKit

public class ArtCollectionInteractor {

    @Published public var arts: [Art] = []
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
        appState.$arts.sink {
            switch $0 {
            case .loading:
                self.isRequestingRefresh = true
            case .success(let arts):
                self.arts = arts
                self.isRequestingRefresh = false
            case .failure(let error):
                self.appState.routePublisher.send(.alert(.error(error)))
                self.isRequestingRefresh = false
            default: break
            } }
            .store(in: &tokens)

        $isRequestingRefresh
            .removeDuplicates()
            .merge(with: $isAppeared)
            .filter { $0 == true }
//        .print()
            .setFailureType(to: Error.self)
            .flatMap { _ in self.museumWebService.fetchArt() }
            .sinkToLoadable { self.appState.arts = $0 }
            .store(in: &tokens)

        $selectedArt
            .compactMap { $0?.id }
            .map { .artDetails(artID: $0) }
            .subscribe(appState.routePublisher)
            .store(in: &tokens)
    }
}
