import Foundation
import MuseumKit
import TimKit
import Combine

public class ArtDetailsPresenter {

    public let model = PassthroughSubject<Model, Never>()

    // TODO: finish this
    // get it from routing
    let appState: AppState
    init(appState: AppState) {
        self.appState = appState
    }

    func bind() {
        // arts needs to be equatable
//        appState.data.$arts
//            .map { $0.first{ $0.id == self.id } }
//        .removeDuplicates(by: <#T##(Art?, Art?) -> Bool#>)
    }
}

public extension ArtDetailsPresenter {
    struct Model {
        public let imageURL: URL?
    }
}
