import Foundation
import MuseumKit

class PortfolioCellModel: Identifiable {

    private let art: Art
    init(art: Art) {
        self.art = art
    }

    var imageURL: URL {
        art.imageURL
    }
}
