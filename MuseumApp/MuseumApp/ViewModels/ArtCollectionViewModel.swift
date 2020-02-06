import Foundation
import MuseumKit
import Combine
import TimKit

public class ArtCollectionViewModel {

    @Published public var arts: [Art] = []
    @Published public var isAppeared = false
    @Published public var isRequestingRefresh = false
    @Published public var selectedArt: Art? = nil

    private var subscriptions: Set<AnyCancellable> = []

    private var appState: AppState
    private let artInteractor: ArtInteractor
    init(appState: AppState,
         artInteractor: ArtInteractor) {
        self.appState = appState
        self.artInteractor = artInteractor
        bindInput()
        bindOutput()
    }

    func bindInput() {
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
    }

    func bindOutput() {
        $isRequestingRefresh
            .removeDuplicates()
            .merge(with: $isAppeared)
            .contains(true)
            .map { _ in self.artInteractor.fetchArts() }
            .sink { $0.store(in: &self.subscriptions) }
            .store(in: &subscriptions)

        $selectedArt
            .compactMap { $0?.id }
            .map { .artDetails(artID: $0) }
            .subscribe(appState.routePublisher)
            .store(in: &subscriptions)
    }
}
