import Combine
import Foundation
import MuseumDomain
import Utils

public class ArtDetailsViewModel {
    @Published public var imageURL: URL?

    private var subscriptions: Set<AnyCancellable> = []

    let artID: String
    let appState: AppState

    public init(artID: String, appState: AppState) {
        self.artID = artID
        self.appState = appState
        bind()
    }

    func bind() {
        appState.$arts
            .compactMap { $0.value }
            .compactMap { $0.first { $0.id == self.artID } }
            .map { $0.imageURL }
            .assign(to: \.imageURL, on: self)
            .store(in: &subscriptions)
    }
}
