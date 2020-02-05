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
        self.museumWebService = museumWebServiceq
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
            .store(in: &tokens)
    }

    func bindOutput() {
        $isRequestingRefresh
            .removeDuplicates()
            .merge(with: $isAppeared)
            .filter { $0 == true }
            .setFailureType(to: Error.self)
            .flatMap { _ in self.museumWebService.fetchArt() }
            .assignToLoadable(to: \.arts, on: appState)
            .store(in: &tokens)

        $selectedArt
            .compactMap { $0?.id }
            .map { .artDetails(artID: $0) }
            .subscribe(appState.routePublisher)
            .store(in: &tokens)
    }
}
