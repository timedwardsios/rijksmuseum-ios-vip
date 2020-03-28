import Foundation
import MuseumDomain
import Combine
import Utils

public class ArtCollectionViewModel {

    @Published public var arts: [Art] = []
    @Published public var isAppeared = false
    @Published public var isRequestingRefresh = false
    @Published public var selectedArt: Art? = nil

    private var subscriptions: Set<AnyCancellable> = []

    private var appState: AppState
    private let artService: ArtService
    init(appState: AppState,
         artInteractor: ArtService) {
        self.appState = appState
        self.artService = artInteractor
        bind()
    }

    func bind() {

        $isRequestingRefresh
            .removeDuplicates()
            .merge(with: $isAppeared)
            .filter { $0 == true }
            .sink { _ in
                self.artService.updateArts()
                    .store(in: &self.subscriptions)
        }.store(in: &subscriptions)

        appState.$arts
            .sink {
                switch $0 {
                case .loading:
                    // this isn't being called :(
                    // can we do something in webservice to forward a loading state?
                    self.isRequestingRefresh = true
                case .success(let arts):
                    self.arts = arts
                    self.isRequestingRefresh = false
                case .failure(let error):
                    self.appState.routePublisher.send(.alert(.error(error)))
                    self.isRequestingRefresh = false
                default: break
                } }
            .store(in: &subscriptions)

        $selectedArt
            .compactMap { $0?.id }
            .map { .artDetails(artID: $0) }
            .subscribe(appState.routePublisher)
            .store(in: &subscriptions)
    }
}
