import Foundation
import MuseumCore
import Utils
import RxSwift
import RxCocoa

public class ArtDetailsViewModel {

    public struct Outputs {
        public let imageURL = BehaviorRelay<URL?>(value: nil)
    }

    public let outputs = Outputs()

    public init(art: Art) {
        self.outputs.imageURL.accept(art.imageURL)
    }
}
