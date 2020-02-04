import Foundation
import MuseumKit
import TimKit
import Combine

public class ArtCollectionPresenter {

    @Published public private(set) var model: Model = .init(arts: [])

    @Published public var isAppeared = false
    @Published public var isRequestingRefresh = false
    @Published public var selectedArt: Art? = nil

    private var tokens: Set<AnyCancellable> = []

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
            .map { Model(arts: $0) }
            .breakpoint()
            .assign(to: \.model, on: self)
            .store(in: &tokens)
    }

    func bindOutput() {
        $isAppeared
            .merge(with: $isRequestingRefresh)
            .filter { $0 == true }
            .sink { _ in self.artInteractor.loadArt().store(in: &self.tokens) }
            .store(in: &tokens)

        $selectedArt
            .compactMap { $0?.id }
            .map { .artDetails(selectedArtID: $0) }
            .assign(to: \.currentRoute, on: appState)
            .store(in: &tokens)
    }
}

public extension ArtCollectionPresenter {
    struct Model {
        public let arts: [Art]
    }
}
