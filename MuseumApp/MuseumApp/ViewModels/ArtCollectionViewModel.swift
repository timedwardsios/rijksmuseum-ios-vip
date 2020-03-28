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
    private let artController: ArtController
    init(appState: AppState,
         artController: ArtController) {
        self.appState = appState
        self.artController = artController
        bind()
    }

    func bind() {

        $isAppeared
            .removeDuplicates()
            .merge(with: $isRequestingRefresh)
            .removeDuplicates()
            .filter { $0 == true }
            .sink { _ in
                self.artController.fetchArts()
                    .store(in: &self.subscriptions)
        }.store(in: &subscriptions)

        appState.$arts
            .sink {
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
            .store(in: &subscriptions)

        $selectedArt
            .compactMap { $0?.id }
            .map { .artDetails(artID: $0) }
            .subscribe(appState.routePublisher)
            .store(in: &subscriptions)
    }
}
