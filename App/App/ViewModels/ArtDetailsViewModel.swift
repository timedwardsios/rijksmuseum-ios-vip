import Foundation
import Core
import Utils
import Combine

public struct ArtDetailsViewModel {

    public struct Outputs {
        public let imageURL = CurrentValueSubject<URL?, Never>(nil)
    }

    public let outputs = Outputs()

    public init(art: Art) {
        self.outputs.imageURL.send(art.imageURL)
    }
}
